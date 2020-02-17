//
//  GrammarVisitor.swift
//
/*
 * *********************************************************************************************************************
 *
 *  BACKENDLESS.COM CONFIDENTIAL
 *
 *  ********************************************************************************************************************
 *
 *  Copyright 2019 BACKENDLESS.COM. All Rights Reserved.
 *
 *  NOTICE: All information contained herein is, and remains the property of Backendless.com and its suppliers,
 *  if any. The intellectual and technical concepts contained herein are proprietary to Backendless.com and its
 *  suppliers and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret
 *  or copyright law. Dissemination of this information or reproduction of this material is strictly forbidden
 *  unless prior written permission is obtained from Backendless.com.
 *
 *  ********************************************************************************************************************
 */

class GrammarVisitor: WhereClauseGrammarBaseVisitor<String> {
    
    override func visitExpression(_ ctx: WhereClauseGrammarParser.ExpressionContext) -> String? {        
        var result: String?
        for expression in ctx.logical_and_expression() {
            if result != nil {
                result = "(\(result!)) OR (\(visit(expression) ?? ""))"
            }
            else {
                result = self.visit(expression)
            }
        }
        return result
    }
    
    override func visitLogical_and_expression(_ ctx: WhereClauseGrammarParser.Logical_and_expressionContext) -> String? {
        var result: String?
        for expression in ctx.negated_expression() {
            if result != nil {
                result = "(\(result!)) AND (\(visit(expression) ?? ""))"
            }
            else {
                result = visit(expression)
            }
        }
        return result
    }
    
    override func visitNegated_expression(_ ctx: WhereClauseGrammarParser.Negated_expressionContext) -> String? {
        var result: String?
        if ctx.NOT() != nil, ctx.negated_expression() != nil {
            result = "NOT \(visit(ctx.negated_expression()!) ?? "")"
        }
        else if ctx.relational_expression() != nil {
            result = visit(ctx.relational_expression()!)
        }
        return result
    }
    
    override func visitParenthed_expression(_ ctx: WhereClauseGrammarParser.Parenthed_expressionContext) -> String? {
        return "(\(visit(ctx.expression()!) ?? ""))"
    }
    
    override func visitIn_expression(_ ctx: WhereClauseGrammarParser.In_expressionContext) -> String? {
        var result: String?
        if let generalElement = ctx.general_element(),
            let field = visit(generalElement),
            let inElements = ctx.in_elements() {
            let list = visitInElements(inElements)
            if ctx.NOT() != nil {
                result = "\(field) NOT IN (\(arrayToString(array: list)))"
            }
            else {
                result = "\(field) IN (\(arrayToString(array: list)))"
            }
        }
        return result
    }
    
    // unchecked?
    override func visitBoolean_expression(_ ctx: WhereClauseGrammarParser.Boolean_expressionContext) -> String? {
        var result: String?
        if let generalElement = ctx.general_element(),
            let field = visit(generalElement) {
            let predicate = ctx.TRUE() != nil
            if ctx.boolean_operator()?.equal != nil {
                result = "\(field) == \(predicate)"
            }
            else {
                result = "\(field) != \(predicate)"
            }
        }
        return result
    }
    
    override func visitArithmetic_comparison_expression(_ ctx: WhereClauseGrammarParser.Arithmetic_comparison_expressionContext) -> String? {
        var result: String?
        let opCtx = ctx.getRuleContext(WhereClauseGrammarParser.Comparison_operatorContext.self, 0)
        if let operatorFn = opCtx?.start?.getText(),
            let field = ctx.arithmetic_expression(0)?.getText(),
            let value = ctx.arithmetic_expression(1)?.getText() {
            result = "\(field)\(operatorFn)\(value)"
        }
        return result
    }
    
    // check for date formatter
    // TODO
    override func visitStringComparisonExpression(_ ctx: WhereClauseGrammarParser.StringComparisonExpressionContext) -> String? {
        var result: String?
        if let opCtx = ctx.getRuleContext(WhereClauseGrammarParser.Comparison_operatorContext.self, 0),
            let operatorFn = opCtx.start?.getText(),
            let generalElement = ctx.general_element(),
            let simpleStringExpression = ctx.simple_string_expression(),
            let field = visit(generalElement),
            let value = visit(simpleStringExpression) {
            result = "\(field)\(operatorFn)'\(value)'"
        }
        return result
    }
    
    override func visitStringLikeExpression(_ ctx: WhereClauseGrammarParser.StringLikeExpressionContext) -> String? {
        var result: String?
        if let generalElement = ctx.general_element(),
            let field = visit(generalElement),
            let quotedString = ctx.quoted_string(),
            let value = visitQuoted_string(quotedString) {
            if ctx.NOT() != nil {
                result = "\(field) NOT LIKE '\(value)'"
            }
            else {
                result = "\(field) LIKE '\(value)'"
            }
        }
        return result
    }
    
    override func visitSimple_string_expression(_ ctx: WhereClauseGrammarParser.Simple_string_expressionContext) -> String? {
        return visitChildren(ctx)
    }
    
    override func visitNull_comparison_expression(_ ctx: WhereClauseGrammarParser.Null_comparison_expressionContext) -> String? {
        var result: String?
        if let generalElement = ctx.general_element(),
            let field = visit(generalElement) {
            if ctx.boolean_operator()?.equal != nil {
                result = "\(field) IS NULL"
            }
            else {
                result = "\(field) IS NOT NULL"
            }
        }
        return result
    }
    
    // TODO
    override func visitDatetime_expression(_ ctx: WhereClauseGrammarParser.Datetime_expressionContext) -> String? {
        print(16)
        return visitChildren(ctx)
        
        /*const field = this.visit(ctx.general_element())
         const timestampOrDateFormat = ctx.timestamp().getText()
         
         const timestamp = (timestampOrDateFormat.startsWith("'") && timestampOrDateFormat.endsWith("'"))
         ? this.unquote(timestampOrDateFormat)
         : timestampOrDateFormat
         
         const at = ctx.datetime_operator().AT() !== null
         const before = ctx.datetime_operator().BEFORE() !== null
         const after = ctx.datetime_operator().AFTER() !== null
         
         let operatorType = OperatorTypes.EQ
         
         if (at && before) {
         operatorType = OperatorTypes.LE
         } else if (at && after) {
         operatorType = OperatorTypes.GE
         } else if (at) {
         operatorType = OperatorTypes.EQ
         } else if (before) {
         operatorType = OperatorTypes.LT
         } else if (after) {
         operatorType = OperatorTypes.GT
         }
         
         return Operators[operatorType](field, timestamp, DataFormatter.DateTime)*/
    }
    
    override func visitGeneral_element(_ ctx: WhereClauseGrammarParser.General_elementContext) -> String? {
        return ctx.getText()
    }
    
    override func visitArithmeticPrimary(_ ctx: WhereClauseGrammarParser.ArithmeticPrimaryContext) -> String? {
        return visitChildren(ctx)
    }
    
    override func visitArithmeticParenthed(_ ctx: WhereClauseGrammarParser.ArithmeticParenthedContext) -> String? {
        var result: String?
        if let arithmeticExpression = ctx.arithmetic_expression() {
            result = visit(arithmeticExpression)
        }
        return result
    }
    
    override func visitArithmetic_primary(_ ctx: WhereClauseGrammarParser.Arithmetic_primaryContext) -> String? {
        return visitChildren(ctx)
    }
    
    // TODO
    override func visitAggregate_expression(_ ctx: WhereClauseGrammarParser.Aggregate_expressionContext) -> String? {
        print(33)
        return visitChildren(ctx)
    }
    
    override func visitNumeric(_ ctx: WhereClauseGrammarParser.NumericContext) -> String? {
        return ctx.getText()
    }
    
    override func visitQuoted_string(_ ctx: WhereClauseGrammarParser.Quoted_stringContext) -> String? {
        guard let quotedString = ctx.CHAR_STRING()?.getText() else { return nil }
        return unquote(quotedString: quotedString)
    }
    
    // *****************************
    
    private func visitInElements(_ ctx: WhereClauseGrammarParser.In_elementsContext) -> [String] {
        var result = [String]()
        let children = ctx.quoted_string() + ctx.numeric()
        for child in children {
            if let childValue = visit(child) {
                result.append(childValue)
            }
        }
        return result
    }
    
    private func arrayToString(array: [String]) -> String {
        var result = ""
        
        for element in array {
            result += "'\(element)', "
        }
        result = String(result.dropLast(2))
        return result
    }
    
    private func unquote(quotedString: String) -> String {
        let startIndex = quotedString.index(quotedString.startIndex, offsetBy: 1)
        let endIndex = quotedString.index(quotedString.endIndex, offsetBy: -1)
        return String(quotedString[startIndex..<endIndex])
    }
    
    // unnecessary?
    // *****************************
    
    //    override func visitRelational_expression(_ ctx: WhereClauseGrammarParser.Relational_expressionContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitLike_escape_part(_ ctx: WhereClauseGrammarParser.Like_escape_partContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitBoolean_operator(_ ctx: WhereClauseGrammarParser.Boolean_operatorContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitIn_elements(_ ctx: WhereClauseGrammarParser.In_elementsContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitDatetime_operator(_ ctx: WhereClauseGrammarParser.Datetime_operatorContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitTimestamp(_ ctx: WhereClauseGrammarParser.TimestampContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitInverse_relation(_ ctx: WhereClauseGrammarParser.Inverse_relationContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitGeo_expression(_ ctx: WhereClauseGrammarParser.Geo_expressionContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitDistance_func(_ ctx: WhereClauseGrammarParser.Distance_funcContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitDistance_arg(_ ctx: WhereClauseGrammarParser.Distance_argContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitUnits_function(_ ctx: WhereClauseGrammarParser.Units_functionContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitMultiplication(_ ctx: WhereClauseGrammarParser.MultiplicationContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitAddition(_ ctx: WhereClauseGrammarParser.AdditionContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitArithmetic_unary(_ ctx: WhereClauseGrammarParser.Arithmetic_unaryContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitFunctions_returning_numerics(_ ctx: WhereClauseGrammarParser.Functions_returning_numericsContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitFunctions_returning_strings(_ ctx: WhereClauseGrammarParser.Functions_returning_stringsContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitString_primary(_ ctx: WhereClauseGrammarParser.String_primaryContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitLike_quoted_string(_ ctx: WhereClauseGrammarParser.Like_quoted_stringContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitComparison_operator(_ ctx: WhereClauseGrammarParser.Comparison_operatorContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitId_expression(_ ctx: WhereClauseGrammarParser.Id_expressionContext) -> String? {
    //        return visitChildren(ctx)
    //    }
    
    //    override func visitRegular_id(_ ctx: WhereClauseGrammarParser.Regular_idContext) -> String? {
    //        return visitChildren(ctx)
    //    }
}

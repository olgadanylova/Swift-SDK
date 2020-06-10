// Generated from WhereClauseGrammar.g4 by ANTLR 4.7.1

/**
 * WARNING! Generated code using ANTLR4 Idea Plugin
 *
 * Steps to build:
 * 1. Right-click on WhereClauseGrammar.g4 and select "Configure ANTLR"
 * 2. Set output directory to <project>/src/main/java
 *    Set package/namespace to "com.backendless.services.persistence.parser.gen"
 *    Select generate parse tree visitor
 * 3. Press Ctrl+Shift+G to generate *.java files
 **/

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link WhereClauseGrammarParser}.
 */
public protocol WhereClauseGrammarListener: ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterExpression(_ ctx: WhereClauseGrammarParser.ExpressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitExpression(_ ctx: WhereClauseGrammarParser.ExpressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#logical_and_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterLogical_and_expression(_ ctx: WhereClauseGrammarParser.Logical_and_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#logical_and_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitLogical_and_expression(_ ctx: WhereClauseGrammarParser.Logical_and_expressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#negated_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterNegated_expression(_ ctx: WhereClauseGrammarParser.Negated_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#negated_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitNegated_expression(_ ctx: WhereClauseGrammarParser.Negated_expressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#relational_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterRelational_expression(_ ctx: WhereClauseGrammarParser.Relational_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#relational_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitRelational_expression(_ ctx: WhereClauseGrammarParser.Relational_expressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#parenthed_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterParenthed_expression(_ ctx: WhereClauseGrammarParser.Parenthed_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#parenthed_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitParenthed_expression(_ ctx: WhereClauseGrammarParser.Parenthed_expressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#in_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterIn_expression(_ ctx: WhereClauseGrammarParser.In_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#in_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitIn_expression(_ ctx: WhereClauseGrammarParser.In_expressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#in_elements}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterIn_elements(_ ctx: WhereClauseGrammarParser.In_elementsContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#in_elements}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitIn_elements(_ ctx: WhereClauseGrammarParser.In_elementsContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#boolean_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterBoolean_expression(_ ctx: WhereClauseGrammarParser.Boolean_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#boolean_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitBoolean_expression(_ ctx: WhereClauseGrammarParser.Boolean_expressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#arithmetic_comparison_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterArithmetic_comparison_expression(_ ctx: WhereClauseGrammarParser.Arithmetic_comparison_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#arithmetic_comparison_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitArithmetic_comparison_expression(_ ctx: WhereClauseGrammarParser.Arithmetic_comparison_expressionContext)
	/**
	 * Enter a parse tree produced by the {@code stringComparisonExpression}
	 * labeled alternative in {@link WhereClauseGrammarParser#string_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStringComparisonExpression(_ ctx: WhereClauseGrammarParser.StringComparisonExpressionContext)
	/**
	 * Exit a parse tree produced by the {@code stringComparisonExpression}
	 * labeled alternative in {@link WhereClauseGrammarParser#string_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStringComparisonExpression(_ ctx: WhereClauseGrammarParser.StringComparisonExpressionContext)
	/**
	 * Enter a parse tree produced by the {@code stringLikeExpression}
	 * labeled alternative in {@link WhereClauseGrammarParser#string_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStringLikeExpression(_ ctx: WhereClauseGrammarParser.StringLikeExpressionContext)
	/**
	 * Exit a parse tree produced by the {@code stringLikeExpression}
	 * labeled alternative in {@link WhereClauseGrammarParser#string_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStringLikeExpression(_ ctx: WhereClauseGrammarParser.StringLikeExpressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#like_escape_part}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterLike_escape_part(_ ctx: WhereClauseGrammarParser.Like_escape_partContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#like_escape_part}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitLike_escape_part(_ ctx: WhereClauseGrammarParser.Like_escape_partContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#simple_string_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterSimple_string_expression(_ ctx: WhereClauseGrammarParser.Simple_string_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#simple_string_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitSimple_string_expression(_ ctx: WhereClauseGrammarParser.Simple_string_expressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#null_comparison_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterNull_comparison_expression(_ ctx: WhereClauseGrammarParser.Null_comparison_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#null_comparison_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitNull_comparison_expression(_ ctx: WhereClauseGrammarParser.Null_comparison_expressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#boolean_operator}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterBoolean_operator(_ ctx: WhereClauseGrammarParser.Boolean_operatorContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#boolean_operator}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitBoolean_operator(_ ctx: WhereClauseGrammarParser.Boolean_operatorContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#datetime_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterDatetime_expression(_ ctx: WhereClauseGrammarParser.Datetime_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#datetime_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitDatetime_expression(_ ctx: WhereClauseGrammarParser.Datetime_expressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#datetime_operator}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterDatetime_operator(_ ctx: WhereClauseGrammarParser.Datetime_operatorContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#datetime_operator}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitDatetime_operator(_ ctx: WhereClauseGrammarParser.Datetime_operatorContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#timestamp}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterTimestamp(_ ctx: WhereClauseGrammarParser.TimestampContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#timestamp}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitTimestamp(_ ctx: WhereClauseGrammarParser.TimestampContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#general_element}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterGeneral_element(_ ctx: WhereClauseGrammarParser.General_elementContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#general_element}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitGeneral_element(_ ctx: WhereClauseGrammarParser.General_elementContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#inverse_relation}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterInverse_relation(_ ctx: WhereClauseGrammarParser.Inverse_relationContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#inverse_relation}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitInverse_relation(_ ctx: WhereClauseGrammarParser.Inverse_relationContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#geo_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterGeo_expression(_ ctx: WhereClauseGrammarParser.Geo_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#geo_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitGeo_expression(_ ctx: WhereClauseGrammarParser.Geo_expressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#distance_func}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterDistance_func(_ ctx: WhereClauseGrammarParser.Distance_funcContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#distance_func}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitDistance_func(_ ctx: WhereClauseGrammarParser.Distance_funcContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#distance_arg}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterDistance_arg(_ ctx: WhereClauseGrammarParser.Distance_argContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#distance_arg}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitDistance_arg(_ ctx: WhereClauseGrammarParser.Distance_argContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#units_function}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterUnits_function(_ ctx: WhereClauseGrammarParser.Units_functionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#units_function}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitUnits_function(_ ctx: WhereClauseGrammarParser.Units_functionContext)
	/**
	 * Enter a parse tree produced by the {@code arithmeticPrimary}
	 * labeled alternative in {@link WhereClauseGrammarParser#arithmetic_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterArithmeticPrimary(_ ctx: WhereClauseGrammarParser.ArithmeticPrimaryContext)
	/**
	 * Exit a parse tree produced by the {@code arithmeticPrimary}
	 * labeled alternative in {@link WhereClauseGrammarParser#arithmetic_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitArithmeticPrimary(_ ctx: WhereClauseGrammarParser.ArithmeticPrimaryContext)
	/**
	 * Enter a parse tree produced by the {@code arithmeticParenthed}
	 * labeled alternative in {@link WhereClauseGrammarParser#arithmetic_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterArithmeticParenthed(_ ctx: WhereClauseGrammarParser.ArithmeticParenthedContext)
	/**
	 * Exit a parse tree produced by the {@code arithmeticParenthed}
	 * labeled alternative in {@link WhereClauseGrammarParser#arithmetic_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitArithmeticParenthed(_ ctx: WhereClauseGrammarParser.ArithmeticParenthedContext)
	/**
	 * Enter a parse tree produced by the {@code multiplication}
	 * labeled alternative in {@link WhereClauseGrammarParser#arithmetic_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterMultiplication(_ ctx: WhereClauseGrammarParser.MultiplicationContext)
	/**
	 * Exit a parse tree produced by the {@code multiplication}
	 * labeled alternative in {@link WhereClauseGrammarParser#arithmetic_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitMultiplication(_ ctx: WhereClauseGrammarParser.MultiplicationContext)
	/**
	 * Enter a parse tree produced by the {@code addition}
	 * labeled alternative in {@link WhereClauseGrammarParser#arithmetic_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterAddition(_ ctx: WhereClauseGrammarParser.AdditionContext)
	/**
	 * Exit a parse tree produced by the {@code addition}
	 * labeled alternative in {@link WhereClauseGrammarParser#arithmetic_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitAddition(_ ctx: WhereClauseGrammarParser.AdditionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#arithmetic_primary}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterArithmetic_primary(_ ctx: WhereClauseGrammarParser.Arithmetic_primaryContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#arithmetic_primary}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitArithmetic_primary(_ ctx: WhereClauseGrammarParser.Arithmetic_primaryContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#arithmetic_unary}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterArithmetic_unary(_ ctx: WhereClauseGrammarParser.Arithmetic_unaryContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#arithmetic_unary}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitArithmetic_unary(_ ctx: WhereClauseGrammarParser.Arithmetic_unaryContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#functions_returning_numerics}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterFunctions_returning_numerics(_ ctx: WhereClauseGrammarParser.Functions_returning_numericsContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#functions_returning_numerics}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitFunctions_returning_numerics(_ ctx: WhereClauseGrammarParser.Functions_returning_numericsContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#functions_returning_strings}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterFunctions_returning_strings(_ ctx: WhereClauseGrammarParser.Functions_returning_stringsContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#functions_returning_strings}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitFunctions_returning_strings(_ ctx: WhereClauseGrammarParser.Functions_returning_stringsContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#aggregate_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterAggregate_expression(_ ctx: WhereClauseGrammarParser.Aggregate_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#aggregate_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitAggregate_expression(_ ctx: WhereClauseGrammarParser.Aggregate_expressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#string_primary}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterString_primary(_ ctx: WhereClauseGrammarParser.String_primaryContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#string_primary}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitString_primary(_ ctx: WhereClauseGrammarParser.String_primaryContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#numeric}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterNumeric(_ ctx: WhereClauseGrammarParser.NumericContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#numeric}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitNumeric(_ ctx: WhereClauseGrammarParser.NumericContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#quoted_string}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterQuoted_string(_ ctx: WhereClauseGrammarParser.Quoted_stringContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#quoted_string}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitQuoted_string(_ ctx: WhereClauseGrammarParser.Quoted_stringContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#like_quoted_string}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterLike_quoted_string(_ ctx: WhereClauseGrammarParser.Like_quoted_stringContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#like_quoted_string}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitLike_quoted_string(_ ctx: WhereClauseGrammarParser.Like_quoted_stringContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#comparison_operator}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterComparison_operator(_ ctx: WhereClauseGrammarParser.Comparison_operatorContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#comparison_operator}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitComparison_operator(_ ctx: WhereClauseGrammarParser.Comparison_operatorContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#id_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterId_expression(_ ctx: WhereClauseGrammarParser.Id_expressionContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#id_expression}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitId_expression(_ ctx: WhereClauseGrammarParser.Id_expressionContext)
	/**
	 * Enter a parse tree produced by {@link WhereClauseGrammarParser#regular_id}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterRegular_id(_ ctx: WhereClauseGrammarParser.Regular_idContext)
	/**
	 * Exit a parse tree produced by {@link WhereClauseGrammarParser#regular_id}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitRegular_id(_ ctx: WhereClauseGrammarParser.Regular_idContext)
}

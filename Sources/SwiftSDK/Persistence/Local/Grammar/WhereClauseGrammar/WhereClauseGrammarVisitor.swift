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
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link WhereClauseGrammarParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
open class WhereClauseGrammarVisitor<T>: ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitExpression(_ ctx: WhereClauseGrammarParser.ExpressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#logical_and_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitLogical_and_expression(_ ctx: WhereClauseGrammarParser.Logical_and_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#negated_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitNegated_expression(_ ctx: WhereClauseGrammarParser.Negated_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#relational_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitRelational_expression(_ ctx: WhereClauseGrammarParser.Relational_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#parenthed_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitParenthed_expression(_ ctx: WhereClauseGrammarParser.Parenthed_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#in_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitIn_expression(_ ctx: WhereClauseGrammarParser.In_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#in_elements}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitIn_elements(_ ctx: WhereClauseGrammarParser.In_elementsContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#boolean_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitBoolean_expression(_ ctx: WhereClauseGrammarParser.Boolean_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#arithmetic_comparison_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitArithmetic_comparison_expression(_ ctx: WhereClauseGrammarParser.Arithmetic_comparison_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code stringComparisonExpression}
	 * labeled alternative in {@link WhereClauseGrammarParser#string_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitStringComparisonExpression(_ ctx: WhereClauseGrammarParser.StringComparisonExpressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code stringLikeExpression}
	 * labeled alternative in {@link WhereClauseGrammarParser#string_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitStringLikeExpression(_ ctx: WhereClauseGrammarParser.StringLikeExpressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#like_escape_part}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitLike_escape_part(_ ctx: WhereClauseGrammarParser.Like_escape_partContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#simple_string_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitSimple_string_expression(_ ctx: WhereClauseGrammarParser.Simple_string_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#null_comparison_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitNull_comparison_expression(_ ctx: WhereClauseGrammarParser.Null_comparison_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#boolean_operator}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitBoolean_operator(_ ctx: WhereClauseGrammarParser.Boolean_operatorContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#datetime_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitDatetime_expression(_ ctx: WhereClauseGrammarParser.Datetime_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#datetime_operator}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitDatetime_operator(_ ctx: WhereClauseGrammarParser.Datetime_operatorContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#timestamp}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitTimestamp(_ ctx: WhereClauseGrammarParser.TimestampContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#general_element}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitGeneral_element(_ ctx: WhereClauseGrammarParser.General_elementContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#inverse_relation}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitInverse_relation(_ ctx: WhereClauseGrammarParser.Inverse_relationContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#geo_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitGeo_expression(_ ctx: WhereClauseGrammarParser.Geo_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#distance_func}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitDistance_func(_ ctx: WhereClauseGrammarParser.Distance_funcContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#distance_arg}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitDistance_arg(_ ctx: WhereClauseGrammarParser.Distance_argContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#units_function}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitUnits_function(_ ctx: WhereClauseGrammarParser.Units_functionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code arithmeticPrimary}
	 * labeled alternative in {@link WhereClauseGrammarParser#arithmetic_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitArithmeticPrimary(_ ctx: WhereClauseGrammarParser.ArithmeticPrimaryContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code arithmeticParenthed}
	 * labeled alternative in {@link WhereClauseGrammarParser#arithmetic_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitArithmeticParenthed(_ ctx: WhereClauseGrammarParser.ArithmeticParenthedContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code multiplication}
	 * labeled alternative in {@link WhereClauseGrammarParser#arithmetic_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitMultiplication(_ ctx: WhereClauseGrammarParser.MultiplicationContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code addition}
	 * labeled alternative in {@link WhereClauseGrammarParser#arithmetic_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitAddition(_ ctx: WhereClauseGrammarParser.AdditionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#arithmetic_primary}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitArithmetic_primary(_ ctx: WhereClauseGrammarParser.Arithmetic_primaryContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#arithmetic_unary}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitArithmetic_unary(_ ctx: WhereClauseGrammarParser.Arithmetic_unaryContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#functions_returning_numerics}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitFunctions_returning_numerics(_ ctx: WhereClauseGrammarParser.Functions_returning_numericsContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#functions_returning_strings}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitFunctions_returning_strings(_ ctx: WhereClauseGrammarParser.Functions_returning_stringsContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#aggregate_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitAggregate_expression(_ ctx: WhereClauseGrammarParser.Aggregate_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#string_primary}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitString_primary(_ ctx: WhereClauseGrammarParser.String_primaryContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#numeric}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitNumeric(_ ctx: WhereClauseGrammarParser.NumericContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#quoted_string}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitQuoted_string(_ ctx: WhereClauseGrammarParser.Quoted_stringContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#like_quoted_string}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitLike_quoted_string(_ ctx: WhereClauseGrammarParser.Like_quoted_stringContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#comparison_operator}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitComparison_operator(_ ctx: WhereClauseGrammarParser.Comparison_operatorContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#id_expression}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitId_expression(_ ctx: WhereClauseGrammarParser.Id_expressionContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link WhereClauseGrammarParser#regular_id}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitRegular_id(_ ctx: WhereClauseGrammarParser.Regular_idContext) -> T {
	 	fatalError(#function + " must be overridden")
	}

}

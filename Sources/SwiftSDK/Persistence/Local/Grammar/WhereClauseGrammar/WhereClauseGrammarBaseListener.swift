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
 * This class provides an empty implementation of {@link WhereClauseGrammarListener},
 * which can be extended to create a listener which only needs to handle a subset
 * of the available methods.
 */
open class WhereClauseGrammarBaseListener: WhereClauseGrammarListener {
     public init() { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterExpression(_ ctx: WhereClauseGrammarParser.ExpressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitExpression(_ ctx: WhereClauseGrammarParser.ExpressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterLogical_and_expression(_ ctx: WhereClauseGrammarParser.Logical_and_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitLogical_and_expression(_ ctx: WhereClauseGrammarParser.Logical_and_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterNegated_expression(_ ctx: WhereClauseGrammarParser.Negated_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitNegated_expression(_ ctx: WhereClauseGrammarParser.Negated_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterRelational_expression(_ ctx: WhereClauseGrammarParser.Relational_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitRelational_expression(_ ctx: WhereClauseGrammarParser.Relational_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterParenthed_expression(_ ctx: WhereClauseGrammarParser.Parenthed_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitParenthed_expression(_ ctx: WhereClauseGrammarParser.Parenthed_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterIn_expression(_ ctx: WhereClauseGrammarParser.In_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitIn_expression(_ ctx: WhereClauseGrammarParser.In_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterIn_elements(_ ctx: WhereClauseGrammarParser.In_elementsContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitIn_elements(_ ctx: WhereClauseGrammarParser.In_elementsContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterBoolean_expression(_ ctx: WhereClauseGrammarParser.Boolean_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitBoolean_expression(_ ctx: WhereClauseGrammarParser.Boolean_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterArithmetic_comparison_expression(_ ctx: WhereClauseGrammarParser.Arithmetic_comparison_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitArithmetic_comparison_expression(_ ctx: WhereClauseGrammarParser.Arithmetic_comparison_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterStringComparisonExpression(_ ctx: WhereClauseGrammarParser.StringComparisonExpressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitStringComparisonExpression(_ ctx: WhereClauseGrammarParser.StringComparisonExpressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterStringLikeExpression(_ ctx: WhereClauseGrammarParser.StringLikeExpressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitStringLikeExpression(_ ctx: WhereClauseGrammarParser.StringLikeExpressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterLike_escape_part(_ ctx: WhereClauseGrammarParser.Like_escape_partContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitLike_escape_part(_ ctx: WhereClauseGrammarParser.Like_escape_partContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterSimple_string_expression(_ ctx: WhereClauseGrammarParser.Simple_string_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitSimple_string_expression(_ ctx: WhereClauseGrammarParser.Simple_string_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterNull_comparison_expression(_ ctx: WhereClauseGrammarParser.Null_comparison_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitNull_comparison_expression(_ ctx: WhereClauseGrammarParser.Null_comparison_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterBoolean_operator(_ ctx: WhereClauseGrammarParser.Boolean_operatorContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitBoolean_operator(_ ctx: WhereClauseGrammarParser.Boolean_operatorContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterDatetime_expression(_ ctx: WhereClauseGrammarParser.Datetime_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitDatetime_expression(_ ctx: WhereClauseGrammarParser.Datetime_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterDatetime_operator(_ ctx: WhereClauseGrammarParser.Datetime_operatorContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitDatetime_operator(_ ctx: WhereClauseGrammarParser.Datetime_operatorContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterTimestamp(_ ctx: WhereClauseGrammarParser.TimestampContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitTimestamp(_ ctx: WhereClauseGrammarParser.TimestampContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterGeneral_element(_ ctx: WhereClauseGrammarParser.General_elementContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitGeneral_element(_ ctx: WhereClauseGrammarParser.General_elementContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterInverse_relation(_ ctx: WhereClauseGrammarParser.Inverse_relationContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitInverse_relation(_ ctx: WhereClauseGrammarParser.Inverse_relationContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterGeo_expression(_ ctx: WhereClauseGrammarParser.Geo_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitGeo_expression(_ ctx: WhereClauseGrammarParser.Geo_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterDistance_func(_ ctx: WhereClauseGrammarParser.Distance_funcContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitDistance_func(_ ctx: WhereClauseGrammarParser.Distance_funcContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterDistance_arg(_ ctx: WhereClauseGrammarParser.Distance_argContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitDistance_arg(_ ctx: WhereClauseGrammarParser.Distance_argContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterUnits_function(_ ctx: WhereClauseGrammarParser.Units_functionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitUnits_function(_ ctx: WhereClauseGrammarParser.Units_functionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterArithmeticPrimary(_ ctx: WhereClauseGrammarParser.ArithmeticPrimaryContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitArithmeticPrimary(_ ctx: WhereClauseGrammarParser.ArithmeticPrimaryContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterArithmeticParenthed(_ ctx: WhereClauseGrammarParser.ArithmeticParenthedContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitArithmeticParenthed(_ ctx: WhereClauseGrammarParser.ArithmeticParenthedContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterMultiplication(_ ctx: WhereClauseGrammarParser.MultiplicationContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitMultiplication(_ ctx: WhereClauseGrammarParser.MultiplicationContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterAddition(_ ctx: WhereClauseGrammarParser.AdditionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitAddition(_ ctx: WhereClauseGrammarParser.AdditionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterArithmetic_primary(_ ctx: WhereClauseGrammarParser.Arithmetic_primaryContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitArithmetic_primary(_ ctx: WhereClauseGrammarParser.Arithmetic_primaryContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterArithmetic_unary(_ ctx: WhereClauseGrammarParser.Arithmetic_unaryContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitArithmetic_unary(_ ctx: WhereClauseGrammarParser.Arithmetic_unaryContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterFunctions_returning_numerics(_ ctx: WhereClauseGrammarParser.Functions_returning_numericsContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitFunctions_returning_numerics(_ ctx: WhereClauseGrammarParser.Functions_returning_numericsContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterFunctions_returning_strings(_ ctx: WhereClauseGrammarParser.Functions_returning_stringsContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitFunctions_returning_strings(_ ctx: WhereClauseGrammarParser.Functions_returning_stringsContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterAggregate_expression(_ ctx: WhereClauseGrammarParser.Aggregate_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitAggregate_expression(_ ctx: WhereClauseGrammarParser.Aggregate_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterString_primary(_ ctx: WhereClauseGrammarParser.String_primaryContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitString_primary(_ ctx: WhereClauseGrammarParser.String_primaryContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterNumeric(_ ctx: WhereClauseGrammarParser.NumericContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitNumeric(_ ctx: WhereClauseGrammarParser.NumericContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterQuoted_string(_ ctx: WhereClauseGrammarParser.Quoted_stringContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitQuoted_string(_ ctx: WhereClauseGrammarParser.Quoted_stringContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterLike_quoted_string(_ ctx: WhereClauseGrammarParser.Like_quoted_stringContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitLike_quoted_string(_ ctx: WhereClauseGrammarParser.Like_quoted_stringContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterComparison_operator(_ ctx: WhereClauseGrammarParser.Comparison_operatorContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitComparison_operator(_ ctx: WhereClauseGrammarParser.Comparison_operatorContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterId_expression(_ ctx: WhereClauseGrammarParser.Id_expressionContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitId_expression(_ ctx: WhereClauseGrammarParser.Id_expressionContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterRegular_id(_ ctx: WhereClauseGrammarParser.Regular_idContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitRegular_id(_ ctx: WhereClauseGrammarParser.Regular_idContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterEveryRule(_ ctx: ParserRuleContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitEveryRule(_ ctx: ParserRuleContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func visitTerminal(_ node: TerminalNode) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func visitErrorNode(_ node: ErrorNode) { }
}

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

open class WhereClauseGrammarParser: Parser {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = WhereClauseGrammarParser._ATN.getNumberOfDecisions()
          for i in 0..<length {
            decisionToDFA.append(DFA(WhereClauseGrammarParser._ATN.getDecisionState(i)!, i))
           }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	enum Tokens: Int {
		case EOF = -1, T__0 = 1, T__1 = 2, T__2 = 3, T__3 = 4, T__4 = 5, T__5 = 6, 
                 T__6 = 7, T__7 = 8, T__8 = 9, T__9 = 10, T__10 = 11, T__11 = 12, 
                 T__12 = 13, T__13 = 14, T__14 = 15, T__15 = 16, AMP_SYMBOL = 17, 
                 AMPAMP_SYMBOL = 18, CARET_SYMBOL = 19, COMMA_SYMBOL = 20, 
                 DOT_SYMBOL = 21, COMMENT_SYMBOL = 22, CONTINUATION_SYMBOL = 23, 
                 EQ_SYMBOL = 24, GE_SYMBOL = 25, GT_SYMBOL = 26, LE_SYMBOL = 27, 
                 LT_SYMBOL = 28, MINUS_SYMBOL = 29, NE_SYMBOL = 30, PLUS_SYMBOL = 31, 
                 STAR_SYMBOL = 32, SLASH_SYMBOL = 33, PERCENT_SYMBOL = 34, 
                 LSQ_BRACKET = 35, RSQ_BRACKET = 36, SINGLE_QUOTE_SYMBOL = 37, 
                 LPAREN = 38, RPAREN = 39, AFTER = 40, AND = 41, AT = 42, 
                 BEFORE = 43, DISTANCE = 44, ESCAPE = 45, FALSE = 46, FT = 47, 
                 IN = 48, IS = 49, KM = 50, LATITUDE = 51, LIKE = 52, LONGITUDE = 53, 
                 M_WORD = 54, MI = 55, NOT = 56, NULL = 57, OR = 58, TRUE = 59, 
                 YD = 60, UNSIGNED_INTEGER = 61, APPROXIMATE_NUM_LIT = 62, 
                 CHAR_STRING = 63, DELIMITED_ID = 64, SPACES = 65, REGULAR_ID = 66, 
                 ZV = 67
	}

	public
	static let RULE_expression = 0, RULE_logical_and_expression = 1, RULE_negated_expression = 2, 
            RULE_relational_expression = 3, RULE_parenthed_expression = 4, 
            RULE_in_expression = 5, RULE_in_elements = 6, RULE_boolean_expression = 7, 
            RULE_arithmetic_comparison_expression = 8, RULE_string_expression = 9, 
            RULE_like_escape_part = 10, RULE_simple_string_expression = 11, 
            RULE_null_comparison_expression = 12, RULE_boolean_operator = 13, 
            RULE_datetime_expression = 14, RULE_datetime_operator = 15, 
            RULE_timestamp = 16, RULE_general_element = 17, RULE_inverse_relation = 18, 
            RULE_geo_expression = 19, RULE_distance_func = 20, RULE_distance_arg = 21, 
            RULE_units_function = 22, RULE_arithmetic_expression = 23, RULE_arithmetic_primary = 24, 
            RULE_arithmetic_unary = 25, RULE_functions_returning_numerics = 26, 
            RULE_functions_returning_strings = 27, RULE_aggregate_expression = 28, 
            RULE_string_primary = 29, RULE_numeric = 30, RULE_quoted_string = 31, 
            RULE_like_quoted_string = 32, RULE_comparison_operator = 33, 
            RULE_id_expression = 34, RULE_regular_id = 35

	public
	static let ruleNames: [String] = [
		"expression", "logical_and_expression", "negated_expression", "relational_expression", 
		"parenthed_expression", "in_expression", "in_elements", "boolean_expression", 
		"arithmetic_comparison_expression", "string_expression", "like_escape_part", 
		"simple_string_expression", "null_comparison_expression", "boolean_operator", 
		"datetime_expression", "datetime_operator", "timestamp", "general_element", 
		"inverse_relation", "geo_expression", "distance_func", "distance_arg", 
		"units_function", "arithmetic_expression", "arithmetic_primary", "arithmetic_unary", 
		"functions_returning_numerics", "functions_returning_strings", "aggregate_expression", 
		"string_primary", "numeric", "quoted_string", "like_quoted_string", "comparison_operator", 
		"id_expression", "regular_id"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'LENGTH'", "'LOCATE'", "'ABS'", "'SQRT'", "'MOD'", "'CONCAT'", "'SUBSTRING'", 
		"'TRIM'", "'LOWER'", "'UPPER'", "'AVG'", "'MAX'", "'MIN'", "'SUM'", "'DISTINCT'", 
		"'COUNT'", "'&'", "'&&'", "'^'", "','", "'.'", "'--'", nil, "'='", nil, 
		"'>'", nil, "'<'", "'-'", nil, "'+'", "'*'", "'/'", "'%'", "'['", "']'", 
		"'''", "'('", "')'", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 
		nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 
		nil, nil, nil, "'@!'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 
		nil, nil, nil, "AMP_SYMBOL", "AMPAMP_SYMBOL", "CARET_SYMBOL", "COMMA_SYMBOL", 
		"DOT_SYMBOL", "COMMENT_SYMBOL", "CONTINUATION_SYMBOL", "EQ_SYMBOL", "GE_SYMBOL", 
		"GT_SYMBOL", "LE_SYMBOL", "LT_SYMBOL", "MINUS_SYMBOL", "NE_SYMBOL", "PLUS_SYMBOL", 
		"STAR_SYMBOL", "SLASH_SYMBOL", "PERCENT_SYMBOL", "LSQ_BRACKET", "RSQ_BRACKET", 
		"SINGLE_QUOTE_SYMBOL", "LPAREN", "RPAREN", "AFTER", "AND", "AT", "BEFORE", 
		"DISTANCE", "ESCAPE", "FALSE", "FT", "IN", "IS", "KM", "LATITUDE", "LIKE", 
		"LONGITUDE", "M_WORD", "MI", "NOT", "NULL", "OR", "TRUE", "YD", "UNSIGNED_INTEGER", 
		"APPROXIMATE_NUM_LIT", "CHAR_STRING", "DELIMITED_ID", "SPACES", "REGULAR_ID", 
		"ZV"
	]
	public
	static let VOCABULARY = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)

	override open
	func getGrammarFileName() -> String { return "WhereClauseGrammar.g4" }

	override open
	func getRuleNames() -> [String] { return WhereClauseGrammarParser.ruleNames }

	override open
	func getSerializedATN() -> String { return WhereClauseGrammarParser._serializedATN }

	override open
	func getATN() -> ATN { return WhereClauseGrammarParser._ATN }

	override open
	func getVocabulary() -> Vocabulary {
	    return WhereClauseGrammarParser.VOCABULARY
	}

	override public
	init(_ input:TokenStream) throws {
	    RuntimeMetaData.checkVersion("4.7.1", RuntimeMetaData.VERSION)
		try super.init(input)
		_interp = ParserATNSimulator(self,WhereClauseGrammarParser._ATN,WhereClauseGrammarParser._decisionToDFA, WhereClauseGrammarParser._sharedContextCache)
	}

	public class ExpressionContext: ParserRuleContext {
			open
			func logical_and_expression() -> [Logical_and_expressionContext] {
				return getRuleContexts(Logical_and_expressionContext.self)
			}
			open
			func logical_and_expression(_ i: Int) -> Logical_and_expressionContext? {
				return getRuleContext(Logical_and_expressionContext.self, i)
			}
			open
			func OR() -> [TerminalNode] {
				return getTokens(WhereClauseGrammarParser.Tokens.OR.rawValue)
			}
			open
			func OR(_ i:Int) -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.OR.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterExpression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitExpression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitExpression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitExpression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func expression() throws -> ExpressionContext {
		var _localctx: ExpressionContext = ExpressionContext(_ctx, getState())
		try enterRule(_localctx, 0, WhereClauseGrammarParser.RULE_expression)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(72)
		 	try logical_and_expression()
		 	setState(77)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.OR.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(73)
		 		try match(WhereClauseGrammarParser.Tokens.OR.rawValue)
		 		setState(74)
		 		try logical_and_expression()


		 		setState(79)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Logical_and_expressionContext: ParserRuleContext {
			open
			func negated_expression() -> [Negated_expressionContext] {
				return getRuleContexts(Negated_expressionContext.self)
			}
			open
			func negated_expression(_ i: Int) -> Negated_expressionContext? {
				return getRuleContext(Negated_expressionContext.self, i)
			}
			open
			func AND() -> [TerminalNode] {
				return getTokens(WhereClauseGrammarParser.Tokens.AND.rawValue)
			}
			open
			func AND(_ i:Int) -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.AND.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_logical_and_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterLogical_and_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitLogical_and_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitLogical_and_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitLogical_and_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func logical_and_expression() throws -> Logical_and_expressionContext {
		var _localctx: Logical_and_expressionContext = Logical_and_expressionContext(_ctx, getState())
		try enterRule(_localctx, 2, WhereClauseGrammarParser.RULE_logical_and_expression)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(80)
		 	try negated_expression()
		 	setState(85)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.AND.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(81)
		 		try match(WhereClauseGrammarParser.Tokens.AND.rawValue)
		 		setState(82)
		 		try negated_expression()


		 		setState(87)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Negated_expressionContext: ParserRuleContext {
			open
			func NOT() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.NOT.rawValue, 0)
			}
			open
			func negated_expression() -> Negated_expressionContext? {
				return getRuleContext(Negated_expressionContext.self, 0)
			}
			open
			func relational_expression() -> Relational_expressionContext? {
				return getRuleContext(Relational_expressionContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_negated_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterNegated_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitNegated_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitNegated_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitNegated_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func negated_expression() throws -> Negated_expressionContext {
		var _localctx: Negated_expressionContext = Negated_expressionContext(_ctx, getState())
		try enterRule(_localctx, 4, WhereClauseGrammarParser.RULE_negated_expression)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(91)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,2, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(88)
		 		try match(WhereClauseGrammarParser.Tokens.NOT.rawValue)
		 		setState(89)
		 		try negated_expression()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(90)
		 		try relational_expression()

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Relational_expressionContext: ParserRuleContext {
			open
			func in_expression() -> In_expressionContext? {
				return getRuleContext(In_expressionContext.self, 0)
			}
			open
			func geo_expression() -> Geo_expressionContext? {
				return getRuleContext(Geo_expressionContext.self, 0)
			}
			open
			func boolean_expression() -> Boolean_expressionContext? {
				return getRuleContext(Boolean_expressionContext.self, 0)
			}
			open
			func null_comparison_expression() -> Null_comparison_expressionContext? {
				return getRuleContext(Null_comparison_expressionContext.self, 0)
			}
			open
			func string_expression() -> String_expressionContext? {
				return getRuleContext(String_expressionContext.self, 0)
			}
			open
			func arithmetic_comparison_expression() -> Arithmetic_comparison_expressionContext? {
				return getRuleContext(Arithmetic_comparison_expressionContext.self, 0)
			}
			open
			func datetime_expression() -> Datetime_expressionContext? {
				return getRuleContext(Datetime_expressionContext.self, 0)
			}
			open
			func parenthed_expression() -> Parenthed_expressionContext? {
				return getRuleContext(Parenthed_expressionContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_relational_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterRelational_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitRelational_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitRelational_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitRelational_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func relational_expression() throws -> Relational_expressionContext {
		var _localctx: Relational_expressionContext = Relational_expressionContext(_ctx, getState())
		try enterRule(_localctx, 6, WhereClauseGrammarParser.RULE_relational_expression)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(101)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,3, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(93)
		 		try in_expression()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(94)
		 		try geo_expression()

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(95)
		 		try boolean_expression()

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(96)
		 		try null_comparison_expression()

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(97)
		 		try string_expression()

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(98)
		 		try arithmetic_comparison_expression()

		 		break
		 	case 7:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(99)
		 		try datetime_expression()

		 		break
		 	case 8:
		 		try enterOuterAlt(_localctx, 8)
		 		setState(100)
		 		try parenthed_expression()

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Parenthed_expressionContext: ParserRuleContext {
			open
			func LPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LPAREN.rawValue, 0)
			}
			open
			func expression() -> ExpressionContext? {
				return getRuleContext(ExpressionContext.self, 0)
			}
			open
			func RPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.RPAREN.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_parenthed_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterParenthed_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitParenthed_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitParenthed_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitParenthed_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func parenthed_expression() throws -> Parenthed_expressionContext {
		var _localctx: Parenthed_expressionContext = Parenthed_expressionContext(_ctx, getState())
		try enterRule(_localctx, 8, WhereClauseGrammarParser.RULE_parenthed_expression)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(103)
		 	try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 	setState(104)
		 	try expression()
		 	setState(105)
		 	try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class In_expressionContext: ParserRuleContext {
			open
			func general_element() -> General_elementContext? {
				return getRuleContext(General_elementContext.self, 0)
			}
			open
			func IN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.IN.rawValue, 0)
			}
			open
			func LPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LPAREN.rawValue, 0)
			}
			open
			func in_elements() -> In_elementsContext? {
				return getRuleContext(In_elementsContext.self, 0)
			}
			open
			func RPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.RPAREN.rawValue, 0)
			}
			open
			func NOT() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.NOT.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_in_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterIn_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitIn_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitIn_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitIn_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func in_expression() throws -> In_expressionContext {
		var _localctx: In_expressionContext = In_expressionContext(_ctx, getState())
		try enterRule(_localctx, 10, WhereClauseGrammarParser.RULE_in_expression)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(107)
		 	try general_element()

		 	setState(109)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.NOT.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(108)
		 		try match(WhereClauseGrammarParser.Tokens.NOT.rawValue)

		 	}

		 	setState(111)
		 	try match(WhereClauseGrammarParser.Tokens.IN.rawValue)
		 	setState(112)
		 	try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 	setState(113)
		 	try in_elements()
		 	setState(114)
		 	try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)



		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class In_elementsContext: ParserRuleContext {
			open
			func quoted_string() -> [Quoted_stringContext] {
				return getRuleContexts(Quoted_stringContext.self)
			}
			open
			func quoted_string(_ i: Int) -> Quoted_stringContext? {
				return getRuleContext(Quoted_stringContext.self, i)
			}
			open
			func numeric() -> [NumericContext] {
				return getRuleContexts(NumericContext.self)
			}
			open
			func numeric(_ i: Int) -> NumericContext? {
				return getRuleContext(NumericContext.self, i)
			}
			open
			func COMMA_SYMBOL() -> [TerminalNode] {
				return getTokens(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
			}
			open
			func COMMA_SYMBOL(_ i:Int) -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_in_elements
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterIn_elements(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitIn_elements(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitIn_elements(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitIn_elements(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func in_elements() throws -> In_elementsContext {
		var _localctx: In_elementsContext = In_elementsContext(_ctx, getState())
		try enterRule(_localctx, 12, WhereClauseGrammarParser.RULE_in_elements)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(118)
		 	try _errHandler.sync(self)
		 	switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .CHAR_STRING:
		 		setState(116)
		 		try quoted_string()

		 		break
		 	case .UNSIGNED_INTEGER:fallthrough
		 	case .APPROXIMATE_NUM_LIT:
		 		setState(117)
		 		try numeric()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		 	setState(127)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(120)
		 		try match(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
		 		setState(123)
		 		try _errHandler.sync(self)
		 		switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
		 		case .CHAR_STRING:
		 			setState(121)
		 			try quoted_string()

		 			break
		 		case .UNSIGNED_INTEGER:fallthrough
		 		case .APPROXIMATE_NUM_LIT:
		 			setState(122)
		 			try numeric()

		 			break
		 		default:
		 			throw ANTLRException.recognition(e: NoViableAltException(self))
		 		}


		 		setState(129)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Boolean_expressionContext: ParserRuleContext {
			open
			func general_element() -> General_elementContext? {
				return getRuleContext(General_elementContext.self, 0)
			}
			open
			func boolean_operator() -> Boolean_operatorContext? {
				return getRuleContext(Boolean_operatorContext.self, 0)
			}
			open
			func TRUE() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.TRUE.rawValue, 0)
			}
			open
			func FALSE() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.FALSE.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_boolean_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterBoolean_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitBoolean_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitBoolean_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitBoolean_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func boolean_expression() throws -> Boolean_expressionContext {
		var _localctx: Boolean_expressionContext = Boolean_expressionContext(_ctx, getState())
		try enterRule(_localctx, 14, WhereClauseGrammarParser.RULE_boolean_expression)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(130)
		 	try general_element()
		 	setState(131)
		 	try boolean_operator()
		 	setState(132)
		 	_la = try _input.LA(1)
		 	if (!(//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.FALSE.rawValue || _la == WhereClauseGrammarParser.Tokens.TRUE.rawValue
		 	      return testSet
		 	 }())) {
		 	try _errHandler.recoverInline(self)
		 	}
		 	else {
		 		_errHandler.reportMatch(self)
		 		try consume()
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Arithmetic_comparison_expressionContext: ParserRuleContext {
			open
			func arithmetic_expression() -> [Arithmetic_expressionContext] {
				return getRuleContexts(Arithmetic_expressionContext.self)
			}
			open
			func arithmetic_expression(_ i: Int) -> Arithmetic_expressionContext? {
				return getRuleContext(Arithmetic_expressionContext.self, i)
			}
			open
			func comparison_operator() -> Comparison_operatorContext? {
				return getRuleContext(Comparison_operatorContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_arithmetic_comparison_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterArithmetic_comparison_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitArithmetic_comparison_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitArithmetic_comparison_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitArithmetic_comparison_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func arithmetic_comparison_expression() throws -> Arithmetic_comparison_expressionContext {
		var _localctx: Arithmetic_comparison_expressionContext = Arithmetic_comparison_expressionContext(_ctx, getState())
		try enterRule(_localctx, 16, WhereClauseGrammarParser.RULE_arithmetic_comparison_expression)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(134)
		 	try arithmetic_expression(0)
		 	setState(135)
		 	try comparison_operator()
		 	setState(136)
		 	try arithmetic_expression(0)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class String_expressionContext: ParserRuleContext {
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_string_expression
		}
	 
		open
		func copyFrom(_ ctx: String_expressionContext) {
			super.copyFrom(ctx)
		}
	}
	public class StringComparisonExpressionContext: String_expressionContext {
			open
			func general_element() -> General_elementContext? {
				return getRuleContext(General_elementContext.self, 0)
			}
			open
			func comparison_operator() -> Comparison_operatorContext? {
				return getRuleContext(Comparison_operatorContext.self, 0)
			}
			open
			func simple_string_expression() -> Simple_string_expressionContext? {
				return getRuleContext(Simple_string_expressionContext.self, 0)
			}

		public
		init(_ ctx: String_expressionContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterStringComparisonExpression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitStringComparisonExpression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitStringComparisonExpression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitStringComparisonExpression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class StringLikeExpressionContext: String_expressionContext {
			open
			func general_element() -> General_elementContext? {
				return getRuleContext(General_elementContext.self, 0)
			}
			open
			func LIKE() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LIKE.rawValue, 0)
			}
			open
			func quoted_string() -> Quoted_stringContext? {
				return getRuleContext(Quoted_stringContext.self, 0)
			}
			open
			func NOT() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.NOT.rawValue, 0)
			}
			open
			func like_escape_part() -> Like_escape_partContext? {
				return getRuleContext(Like_escape_partContext.self, 0)
			}

		public
		init(_ ctx: String_expressionContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterStringLikeExpression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitStringLikeExpression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitStringLikeExpression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitStringLikeExpression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func string_expression() throws -> String_expressionContext {
		var _localctx: String_expressionContext = String_expressionContext(_ctx, getState())
		try enterRule(_localctx, 18, WhereClauseGrammarParser.RULE_string_expression)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(151)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,10, _ctx)) {
		 	case 1:
		 		_localctx =  StringComparisonExpressionContext(_localctx);
		 		try enterOuterAlt(_localctx, 1)
		 		setState(138)
		 		try general_element()
		 		setState(139)
		 		try comparison_operator()
		 		setState(140)
		 		try simple_string_expression()

		 		break
		 	case 2:
		 		_localctx =  StringLikeExpressionContext(_localctx);
		 		try enterOuterAlt(_localctx, 2)
		 		setState(142)
		 		try general_element()

		 		setState(144)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.NOT.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(143)
		 			try match(WhereClauseGrammarParser.Tokens.NOT.rawValue)

		 		}

		 		setState(146)
		 		try match(WhereClauseGrammarParser.Tokens.LIKE.rawValue)
		 		setState(147)
		 		try quoted_string()
		 		setState(149)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.ESCAPE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(148)
		 			try like_escape_part()

		 		}




		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Like_escape_partContext: ParserRuleContext {
			open
			func ESCAPE() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.ESCAPE.rawValue, 0)
			}
			open
			func simple_string_expression() -> Simple_string_expressionContext? {
				return getRuleContext(Simple_string_expressionContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_like_escape_part
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterLike_escape_part(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitLike_escape_part(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitLike_escape_part(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitLike_escape_part(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func like_escape_part() throws -> Like_escape_partContext {
		var _localctx: Like_escape_partContext = Like_escape_partContext(_ctx, getState())
		try enterRule(_localctx, 20, WhereClauseGrammarParser.RULE_like_escape_part)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(153)
		 	try match(WhereClauseGrammarParser.Tokens.ESCAPE.rawValue)
		 	setState(154)
		 	try simple_string_expression()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Simple_string_expressionContext: ParserRuleContext {
			open
			func general_element() -> General_elementContext? {
				return getRuleContext(General_elementContext.self, 0)
			}
			open
			func quoted_string() -> Quoted_stringContext? {
				return getRuleContext(Quoted_stringContext.self, 0)
			}
			open
			func functions_returning_strings() -> Functions_returning_stringsContext? {
				return getRuleContext(Functions_returning_stringsContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_simple_string_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterSimple_string_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitSimple_string_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitSimple_string_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitSimple_string_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func simple_string_expression() throws -> Simple_string_expressionContext {
		var _localctx: Simple_string_expressionContext = Simple_string_expressionContext(_ctx, getState())
		try enterRule(_localctx, 22, WhereClauseGrammarParser.RULE_simple_string_expression)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(159)
		 	try _errHandler.sync(self)
		 	switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .AND:fallthrough
		 	case .DISTANCE:fallthrough
		 	case .FALSE:fallthrough
		 	case .FT:fallthrough
		 	case .IN:fallthrough
		 	case .IS:fallthrough
		 	case .KM:fallthrough
		 	case .LATITUDE:fallthrough
		 	case .LIKE:fallthrough
		 	case .LONGITUDE:fallthrough
		 	case .M_WORD:fallthrough
		 	case .MI:fallthrough
		 	case .NOT:fallthrough
		 	case .NULL:fallthrough
		 	case .OR:fallthrough
		 	case .TRUE:fallthrough
		 	case .YD:fallthrough
		 	case .REGULAR_ID:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(156)
		 		try general_element()

		 		break

		 	case .CHAR_STRING:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(157)
		 		try quoted_string()

		 		break
		 	case .T__5:fallthrough
		 	case .T__6:fallthrough
		 	case .T__7:fallthrough
		 	case .T__8:fallthrough
		 	case .T__9:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(158)
		 		try functions_returning_strings()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Null_comparison_expressionContext: ParserRuleContext {
			open
			func general_element() -> General_elementContext? {
				return getRuleContext(General_elementContext.self, 0)
			}
			open
			func boolean_operator() -> Boolean_operatorContext? {
				return getRuleContext(Boolean_operatorContext.self, 0)
			}
			open
			func NULL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.NULL.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_null_comparison_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterNull_comparison_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitNull_comparison_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitNull_comparison_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitNull_comparison_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func null_comparison_expression() throws -> Null_comparison_expressionContext {
		var _localctx: Null_comparison_expressionContext = Null_comparison_expressionContext(_ctx, getState())
		try enterRule(_localctx, 24, WhereClauseGrammarParser.RULE_null_comparison_expression)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(161)
		 	try general_element()
		 	setState(162)
		 	try boolean_operator()
		 	setState(163)
		 	try match(WhereClauseGrammarParser.Tokens.NULL.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Boolean_operatorContext: ParserRuleContext {
		open var equal: Token!
			open
			func EQ_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.EQ_SYMBOL.rawValue, 0)
			}
			open
			func IS() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.IS.rawValue, 0)
			}
			open
			func NE_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.NE_SYMBOL.rawValue, 0)
			}
			open
			func NOT() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.NOT.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_boolean_operator
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterBoolean_operator(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitBoolean_operator(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitBoolean_operator(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitBoolean_operator(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func boolean_operator() throws -> Boolean_operatorContext {
		var _localctx: Boolean_operatorContext = Boolean_operatorContext(_ctx, getState())
		try enterRule(_localctx, 26, WhereClauseGrammarParser.RULE_boolean_operator)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(171)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,13, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(165)
		 		_localctx.castdown(Boolean_operatorContext.self).equal = try _input.LT(1)
		 		_la = try _input.LA(1)
		 		if (!(//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.EQ_SYMBOL.rawValue || _la == WhereClauseGrammarParser.Tokens.IS.rawValue
		 		      return testSet
		 		 }())) {
		 			_localctx.castdown(Boolean_operatorContext.self).equal = try _errHandler.recoverInline(self) as Token
		 		}
		 		else {
		 			_errHandler.reportMatch(self)
		 			try consume()
		 		}

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(169)
		 		try _errHandler.sync(self)
		 		switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
		 		case .NE_SYMBOL:
		 			setState(166)
		 			try match(WhereClauseGrammarParser.Tokens.NE_SYMBOL.rawValue)

		 			break

		 		case .IS:
		 			setState(167)
		 			try match(WhereClauseGrammarParser.Tokens.IS.rawValue)
		 			setState(168)
		 			try match(WhereClauseGrammarParser.Tokens.NOT.rawValue)

		 			break
		 		default:
		 			throw ANTLRException.recognition(e: NoViableAltException(self))
		 		}

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Datetime_expressionContext: ParserRuleContext {
			open
			func general_element() -> General_elementContext? {
				return getRuleContext(General_elementContext.self, 0)
			}
			open
			func datetime_operator() -> Datetime_operatorContext? {
				return getRuleContext(Datetime_operatorContext.self, 0)
			}
			open
			func timestamp() -> TimestampContext? {
				return getRuleContext(TimestampContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_datetime_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterDatetime_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitDatetime_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitDatetime_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitDatetime_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func datetime_expression() throws -> Datetime_expressionContext {
		var _localctx: Datetime_expressionContext = Datetime_expressionContext(_ctx, getState())
		try enterRule(_localctx, 28, WhereClauseGrammarParser.RULE_datetime_expression)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(173)
		 	try general_element()
		 	setState(174)
		 	try datetime_operator()
		 	setState(175)
		 	try timestamp()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Datetime_operatorContext: ParserRuleContext {
			open
			func AT() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.AT.rawValue, 0)
			}
			open
			func AFTER() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.AFTER.rawValue, 0)
			}
			open
			func BEFORE() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.BEFORE.rawValue, 0)
			}
			open
			func OR() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.OR.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_datetime_operator
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterDatetime_operator(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitDatetime_operator(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitDatetime_operator(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitDatetime_operator(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func datetime_operator() throws -> Datetime_operatorContext {
		var _localctx: Datetime_operatorContext = Datetime_operatorContext(_ctx, getState())
		try enterRule(_localctx, 30, WhereClauseGrammarParser.RULE_datetime_operator)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(186)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,14, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(177)
		 		try match(WhereClauseGrammarParser.Tokens.AT.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(178)
		 		try match(WhereClauseGrammarParser.Tokens.AFTER.rawValue)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(179)
		 		try match(WhereClauseGrammarParser.Tokens.BEFORE.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(180)
		 		try match(WhereClauseGrammarParser.Tokens.AT.rawValue)
		 		setState(181)
		 		try match(WhereClauseGrammarParser.Tokens.OR.rawValue)
		 		setState(182)
		 		try match(WhereClauseGrammarParser.Tokens.AFTER.rawValue)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(183)
		 		try match(WhereClauseGrammarParser.Tokens.AT.rawValue)
		 		setState(184)
		 		try match(WhereClauseGrammarParser.Tokens.OR.rawValue)
		 		setState(185)
		 		try match(WhereClauseGrammarParser.Tokens.BEFORE.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class TimestampContext: ParserRuleContext {
			open
			func numeric() -> NumericContext? {
				return getRuleContext(NumericContext.self, 0)
			}
			open
			func quoted_string() -> Quoted_stringContext? {
				return getRuleContext(Quoted_stringContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_timestamp
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterTimestamp(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitTimestamp(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitTimestamp(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitTimestamp(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func timestamp() throws -> TimestampContext {
		var _localctx: TimestampContext = TimestampContext(_ctx, getState())
		try enterRule(_localctx, 32, WhereClauseGrammarParser.RULE_timestamp)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(190)
		 	try _errHandler.sync(self)
		 	switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .UNSIGNED_INTEGER:fallthrough
		 	case .APPROXIMATE_NUM_LIT:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(188)
		 		try numeric()

		 		break

		 	case .CHAR_STRING:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(189)
		 		try quoted_string()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class General_elementContext: ParserRuleContext {
			open
			func id_expression() -> Id_expressionContext? {
				return getRuleContext(Id_expressionContext.self, 0)
			}
			open
			func inverse_relation() -> [Inverse_relationContext] {
				return getRuleContexts(Inverse_relationContext.self)
			}
			open
			func inverse_relation(_ i: Int) -> Inverse_relationContext? {
				return getRuleContext(Inverse_relationContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_general_element
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterGeneral_element(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitGeneral_element(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitGeneral_element(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitGeneral_element(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func general_element() throws -> General_elementContext {
		var _localctx: General_elementContext = General_elementContext(_ctx, getState())
		try enterRule(_localctx, 34, WhereClauseGrammarParser.RULE_general_element)
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(195)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,16,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(192)
		 			try inverse_relation()

		 	 
		 		}
		 		setState(197)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,16,_ctx)
		 	}
		 	setState(198)
		 	try id_expression()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Inverse_relationContext: ParserRuleContext {
		open var parentTable: Regular_idContext!
		open var relationColumn: Regular_idContext!
			open
			func LSQ_BRACKET() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LSQ_BRACKET.rawValue, 0)
			}
			open
			func RSQ_BRACKET() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.RSQ_BRACKET.rawValue, 0)
			}
			open
			func DOT_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.DOT_SYMBOL.rawValue, 0)
			}
			open
			func regular_id() -> [Regular_idContext] {
				return getRuleContexts(Regular_idContext.self)
			}
			open
			func regular_id(_ i: Int) -> Regular_idContext? {
				return getRuleContext(Regular_idContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_inverse_relation
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterInverse_relation(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitInverse_relation(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitInverse_relation(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitInverse_relation(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func inverse_relation() throws -> Inverse_relationContext {
		var _localctx: Inverse_relationContext = Inverse_relationContext(_ctx, getState())
		try enterRule(_localctx, 36, WhereClauseGrammarParser.RULE_inverse_relation)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(200)
		 	try {
		 			let assignmentValue = try regular_id()
		 			_localctx.castdown(Inverse_relationContext.self).parentTable = assignmentValue
		 	     }()

		 	setState(201)
		 	try match(WhereClauseGrammarParser.Tokens.LSQ_BRACKET.rawValue)
		 	setState(202)
		 	try {
		 			let assignmentValue = try regular_id()
		 			_localctx.castdown(Inverse_relationContext.self).relationColumn = assignmentValue
		 	     }()

		 	setState(203)
		 	try match(WhereClauseGrammarParser.Tokens.RSQ_BRACKET.rawValue)
		 	setState(204)
		 	try match(WhereClauseGrammarParser.Tokens.DOT_SYMBOL.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Geo_expressionContext: ParserRuleContext {
			open
			func distance_func() -> Distance_funcContext? {
				return getRuleContext(Distance_funcContext.self, 0)
			}
			open
			func comparison_operator() -> Comparison_operatorContext? {
				return getRuleContext(Comparison_operatorContext.self, 0)
			}
			open
			func units_function() -> Units_functionContext? {
				return getRuleContext(Units_functionContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_geo_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterGeo_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitGeo_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitGeo_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitGeo_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func geo_expression() throws -> Geo_expressionContext {
		var _localctx: Geo_expressionContext = Geo_expressionContext(_ctx, getState())
		try enterRule(_localctx, 38, WhereClauseGrammarParser.RULE_geo_expression)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(206)
		 	try distance_func()
		 	setState(207)
		 	try comparison_operator()
		 	setState(208)
		 	try units_function()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Distance_funcContext: ParserRuleContext {
			open
			func DISTANCE() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.DISTANCE.rawValue, 0)
			}
			open
			func LPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LPAREN.rawValue, 0)
			}
			open
			func distance_arg() -> [Distance_argContext] {
				return getRuleContexts(Distance_argContext.self)
			}
			open
			func distance_arg(_ i: Int) -> Distance_argContext? {
				return getRuleContext(Distance_argContext.self, i)
			}
			open
			func COMMA_SYMBOL() -> [TerminalNode] {
				return getTokens(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
			}
			open
			func COMMA_SYMBOL(_ i:Int) -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue, i)
			}
			open
			func RPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.RPAREN.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_distance_func
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterDistance_func(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitDistance_func(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitDistance_func(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitDistance_func(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func distance_func() throws -> Distance_funcContext {
		var _localctx: Distance_funcContext = Distance_funcContext(_ctx, getState())
		try enterRule(_localctx, 40, WhereClauseGrammarParser.RULE_distance_func)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(210)
		 	try match(WhereClauseGrammarParser.Tokens.DISTANCE.rawValue)
		 	setState(211)
		 	try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 	setState(212)
		 	try distance_arg()
		 	setState(213)
		 	try match(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
		 	setState(214)
		 	try distance_arg()
		 	setState(215)
		 	try match(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
		 	setState(216)
		 	try distance_arg()
		 	setState(217)
		 	try match(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
		 	setState(218)
		 	try distance_arg()
		 	setState(219)
		 	try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Distance_argContext: ParserRuleContext {
			open
			func numeric() -> NumericContext? {
				return getRuleContext(NumericContext.self, 0)
			}
			open
			func MINUS_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.MINUS_SYMBOL.rawValue, 0)
			}
			open
			func general_element() -> General_elementContext? {
				return getRuleContext(General_elementContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_distance_arg
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterDistance_arg(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitDistance_arg(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitDistance_arg(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitDistance_arg(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func distance_arg() throws -> Distance_argContext {
		var _localctx: Distance_argContext = Distance_argContext(_ctx, getState())
		try enterRule(_localctx, 42, WhereClauseGrammarParser.RULE_distance_arg)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(226)
		 	try _errHandler.sync(self)
		 	switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .MINUS_SYMBOL:fallthrough
		 	case .UNSIGNED_INTEGER:fallthrough
		 	case .APPROXIMATE_NUM_LIT:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(222)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.MINUS_SYMBOL.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(221)
		 			try match(WhereClauseGrammarParser.Tokens.MINUS_SYMBOL.rawValue)

		 		}

		 		setState(224)
		 		try numeric()

		 		break
		 	case .AND:fallthrough
		 	case .DISTANCE:fallthrough
		 	case .FALSE:fallthrough
		 	case .FT:fallthrough
		 	case .IN:fallthrough
		 	case .IS:fallthrough
		 	case .KM:fallthrough
		 	case .LATITUDE:fallthrough
		 	case .LIKE:fallthrough
		 	case .LONGITUDE:fallthrough
		 	case .M_WORD:fallthrough
		 	case .MI:fallthrough
		 	case .NOT:fallthrough
		 	case .NULL:fallthrough
		 	case .OR:fallthrough
		 	case .TRUE:fallthrough
		 	case .YD:fallthrough
		 	case .REGULAR_ID:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(225)
		 		try general_element()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Units_functionContext: ParserRuleContext {
		open var unit: Token!
			open
			func LPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LPAREN.rawValue, 0)
			}
			open
			func numeric() -> NumericContext? {
				return getRuleContext(NumericContext.self, 0)
			}
			open
			func RPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.RPAREN.rawValue, 0)
			}
			open
			func FT() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.FT.rawValue, 0)
			}
			open
			func KM() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.KM.rawValue, 0)
			}
			open
			func MI() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.MI.rawValue, 0)
			}
			open
			func YD() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.YD.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_units_function
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterUnits_function(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitUnits_function(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitUnits_function(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitUnits_function(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func units_function() throws -> Units_functionContext {
		var _localctx: Units_functionContext = Units_functionContext(_ctx, getState())
		try enterRule(_localctx, 44, WhereClauseGrammarParser.RULE_units_function)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(234)
		 	try _errHandler.sync(self)
		 	switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .FT:fallthrough
		 	case .KM:fallthrough
		 	case .MI:fallthrough
		 	case .YD:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(228)
		 		_localctx.castdown(Units_functionContext.self).unit = try _input.LT(1)
		 		_la = try _input.LA(1)
		 		if (!(//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = {  () -> Bool in
		 		   let testArray: [Int] = [_la, WhereClauseGrammarParser.Tokens.FT.rawValue,WhereClauseGrammarParser.Tokens.KM.rawValue,WhereClauseGrammarParser.Tokens.MI.rawValue,WhereClauseGrammarParser.Tokens.YD.rawValue]
		 		    return  Utils.testBitLeftShiftArray(testArray, 0)
		 		}()
		 		      return testSet
		 		 }())) {
		 			_localctx.castdown(Units_functionContext.self).unit = try _errHandler.recoverInline(self) as Token
		 		}
		 		else {
		 			_errHandler.reportMatch(self)
		 			try consume()
		 		}
		 		setState(229)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(230)
		 		try numeric()
		 		setState(231)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break
		 	case .UNSIGNED_INTEGER:fallthrough
		 	case .APPROXIMATE_NUM_LIT:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(233)
		 		try numeric()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Arithmetic_expressionContext: ParserRuleContext {
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_arithmetic_expression
		}
	 
		open
		func copyFrom(_ ctx: Arithmetic_expressionContext) {
			super.copyFrom(ctx)
		}
	}
	public class ArithmeticPrimaryContext: Arithmetic_expressionContext {
			open
			func arithmetic_primary() -> Arithmetic_primaryContext? {
				return getRuleContext(Arithmetic_primaryContext.self, 0)
			}

		public
		init(_ ctx: Arithmetic_expressionContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterArithmeticPrimary(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitArithmeticPrimary(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitArithmeticPrimary(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitArithmeticPrimary(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class ArithmeticParenthedContext: Arithmetic_expressionContext {
			open
			func LPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LPAREN.rawValue, 0)
			}
			open
			func arithmetic_expression() -> Arithmetic_expressionContext? {
				return getRuleContext(Arithmetic_expressionContext.self, 0)
			}
			open
			func RPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.RPAREN.rawValue, 0)
			}

		public
		init(_ ctx: Arithmetic_expressionContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterArithmeticParenthed(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitArithmeticParenthed(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitArithmeticParenthed(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitArithmeticParenthed(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class MultiplicationContext: Arithmetic_expressionContext {
		public var operation: Token!
			open
			func arithmetic_expression() -> [Arithmetic_expressionContext] {
				return getRuleContexts(Arithmetic_expressionContext.self)
			}
			open
			func arithmetic_expression(_ i: Int) -> Arithmetic_expressionContext? {
				return getRuleContext(Arithmetic_expressionContext.self, i)
			}
			open
			func STAR_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.STAR_SYMBOL.rawValue, 0)
			}
			open
			func SLASH_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.SLASH_SYMBOL.rawValue, 0)
			}

		public
		init(_ ctx: Arithmetic_expressionContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterMultiplication(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitMultiplication(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitMultiplication(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitMultiplication(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	public class AdditionContext: Arithmetic_expressionContext {
		public var operation: Token!
			open
			func arithmetic_expression() -> [Arithmetic_expressionContext] {
				return getRuleContexts(Arithmetic_expressionContext.self)
			}
			open
			func arithmetic_expression(_ i: Int) -> Arithmetic_expressionContext? {
				return getRuleContext(Arithmetic_expressionContext.self, i)
			}
			open
			func PLUS_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.PLUS_SYMBOL.rawValue, 0)
			}
			open
			func MINUS_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.MINUS_SYMBOL.rawValue, 0)
			}

		public
		init(_ ctx: Arithmetic_expressionContext) {
			super.init()
			copyFrom(ctx)
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterAddition(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitAddition(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitAddition(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitAddition(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}

	 public final  func arithmetic_expression( ) throws -> Arithmetic_expressionContext   {
		return try arithmetic_expression(0)
	}
	@discardableResult
	private func arithmetic_expression(_ _p: Int) throws -> Arithmetic_expressionContext   {
		let _parentctx: ParserRuleContext? = _ctx
		var _parentState: Int = getState()
		var _localctx: Arithmetic_expressionContext = Arithmetic_expressionContext(_ctx, _parentState)
		var  _prevctx: Arithmetic_expressionContext = _localctx
		var _startState: Int = 46
		try enterRecursionRule(_localctx, 46, WhereClauseGrammarParser.RULE_arithmetic_expression, _p)
		var _la: Int = 0
		defer {
	    		try! unrollRecursionContexts(_parentctx)
	    }
		do {
			var _alt: Int
			try enterOuterAlt(_localctx, 1)
			setState(242)
			try _errHandler.sync(self)
			switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
			case .LPAREN:
				_localctx = ArithmeticParenthedContext(_localctx)
				_ctx = _localctx
				_prevctx = _localctx

				setState(237)
				try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
				setState(238)
				try arithmetic_expression(0)
				setState(239)
				try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

				break
			case .T__0:fallthrough
			case .T__1:fallthrough
			case .T__2:fallthrough
			case .T__3:fallthrough
			case .T__4:fallthrough
			case .T__10:fallthrough
			case .T__11:fallthrough
			case .T__12:fallthrough
			case .T__13:fallthrough
			case .T__15:fallthrough
			case .MINUS_SYMBOL:fallthrough
			case .PLUS_SYMBOL:fallthrough
			case .AND:fallthrough
			case .DISTANCE:fallthrough
			case .FALSE:fallthrough
			case .FT:fallthrough
			case .IN:fallthrough
			case .IS:fallthrough
			case .KM:fallthrough
			case .LATITUDE:fallthrough
			case .LIKE:fallthrough
			case .LONGITUDE:fallthrough
			case .M_WORD:fallthrough
			case .MI:fallthrough
			case .NOT:fallthrough
			case .NULL:fallthrough
			case .OR:fallthrough
			case .TRUE:fallthrough
			case .YD:fallthrough
			case .UNSIGNED_INTEGER:fallthrough
			case .APPROXIMATE_NUM_LIT:fallthrough
			case .REGULAR_ID:
				_localctx = ArithmeticPrimaryContext(_localctx)
				_ctx = _localctx
				_prevctx = _localctx
				setState(241)
				try arithmetic_primary()

				break
			default:
				throw ANTLRException.recognition(e: NoViableAltException(self))
			}
			_ctx!.stop = try _input.LT(-1)
			setState(252)
			try _errHandler.sync(self)
			_alt = try getInterpreter().adaptivePredict(_input,22,_ctx)
			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
				if ( _alt==1 ) {
					if _parseListeners != nil {
					   try triggerExitRuleEvent()
					}
					_prevctx = _localctx
					setState(250)
					try _errHandler.sync(self)
					switch(try getInterpreter().adaptivePredict(_input,21, _ctx)) {
					case 1:
						_localctx = MultiplicationContext(  Arithmetic_expressionContext(_parentctx, _parentState))
						try pushNewRecursionContext(_localctx, _startState, WhereClauseGrammarParser.RULE_arithmetic_expression)
						setState(244)
						if (!(precpred(_ctx, 4))) {
						    throw ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 4)"))
						}
						setState(245)
						_localctx.castdown(MultiplicationContext.self).operation = try _input.LT(1)
						_la = try _input.LA(1)
						if (!(//closure
						 { () -> Bool in
						      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.STAR_SYMBOL.rawValue || _la == WhereClauseGrammarParser.Tokens.SLASH_SYMBOL.rawValue
						      return testSet
						 }())) {
							_localctx.castdown(MultiplicationContext.self).operation = try _errHandler.recoverInline(self) as Token
						}
						else {
							_errHandler.reportMatch(self)
							try consume()
						}
						setState(246)
						try arithmetic_expression(5)

						break
					case 2:
						_localctx = AdditionContext(  Arithmetic_expressionContext(_parentctx, _parentState))
						try pushNewRecursionContext(_localctx, _startState, WhereClauseGrammarParser.RULE_arithmetic_expression)
						setState(247)
						if (!(precpred(_ctx, 3))) {
						    throw ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 3)"))
						}
						setState(248)
						_localctx.castdown(AdditionContext.self).operation = try _input.LT(1)
						_la = try _input.LA(1)
						if (!(//closure
						 { () -> Bool in
						      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.MINUS_SYMBOL.rawValue || _la == WhereClauseGrammarParser.Tokens.PLUS_SYMBOL.rawValue
						      return testSet
						 }())) {
							_localctx.castdown(AdditionContext.self).operation = try _errHandler.recoverInline(self) as Token
						}
						else {
							_errHandler.reportMatch(self)
							try consume()
						}
						setState(249)
						try arithmetic_expression(4)

						break
					default: break
					}
			 
				}
				setState(254)
				try _errHandler.sync(self)
				_alt = try getInterpreter().adaptivePredict(_input,22,_ctx)
			}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx;
	}

	public class Arithmetic_primaryContext: ParserRuleContext {
			open
			func general_element() -> General_elementContext? {
				return getRuleContext(General_elementContext.self, 0)
			}
			open
			func numeric() -> NumericContext? {
				return getRuleContext(NumericContext.self, 0)
			}
			open
			func functions_returning_numerics() -> Functions_returning_numericsContext? {
				return getRuleContext(Functions_returning_numericsContext.self, 0)
			}
			open
			func aggregate_expression() -> Aggregate_expressionContext? {
				return getRuleContext(Aggregate_expressionContext.self, 0)
			}
			open
			func arithmetic_unary() -> Arithmetic_unaryContext? {
				return getRuleContext(Arithmetic_unaryContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_arithmetic_primary
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterArithmetic_primary(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitArithmetic_primary(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitArithmetic_primary(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitArithmetic_primary(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func arithmetic_primary() throws -> Arithmetic_primaryContext {
		var _localctx: Arithmetic_primaryContext = Arithmetic_primaryContext(_ctx, getState())
		try enterRule(_localctx, 48, WhereClauseGrammarParser.RULE_arithmetic_primary)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(260)
		 	try _errHandler.sync(self)
		 	switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .AND:fallthrough
		 	case .DISTANCE:fallthrough
		 	case .FALSE:fallthrough
		 	case .FT:fallthrough
		 	case .IN:fallthrough
		 	case .IS:fallthrough
		 	case .KM:fallthrough
		 	case .LATITUDE:fallthrough
		 	case .LIKE:fallthrough
		 	case .LONGITUDE:fallthrough
		 	case .M_WORD:fallthrough
		 	case .MI:fallthrough
		 	case .NOT:fallthrough
		 	case .NULL:fallthrough
		 	case .OR:fallthrough
		 	case .TRUE:fallthrough
		 	case .YD:fallthrough
		 	case .REGULAR_ID:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(255)
		 		try general_element()

		 		break
		 	case .UNSIGNED_INTEGER:fallthrough
		 	case .APPROXIMATE_NUM_LIT:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(256)
		 		try numeric()

		 		break
		 	case .T__0:fallthrough
		 	case .T__1:fallthrough
		 	case .T__2:fallthrough
		 	case .T__3:fallthrough
		 	case .T__4:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(257)
		 		try functions_returning_numerics()

		 		break
		 	case .T__10:fallthrough
		 	case .T__11:fallthrough
		 	case .T__12:fallthrough
		 	case .T__13:fallthrough
		 	case .T__15:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(258)
		 		try aggregate_expression()

		 		break
		 	case .MINUS_SYMBOL:fallthrough
		 	case .PLUS_SYMBOL:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(259)
		 		try arithmetic_unary()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Arithmetic_unaryContext: ParserRuleContext {
			open
			func arithmetic_expression() -> Arithmetic_expressionContext? {
				return getRuleContext(Arithmetic_expressionContext.self, 0)
			}
			open
			func PLUS_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.PLUS_SYMBOL.rawValue, 0)
			}
			open
			func MINUS_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.MINUS_SYMBOL.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_arithmetic_unary
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterArithmetic_unary(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitArithmetic_unary(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitArithmetic_unary(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitArithmetic_unary(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func arithmetic_unary() throws -> Arithmetic_unaryContext {
		var _localctx: Arithmetic_unaryContext = Arithmetic_unaryContext(_ctx, getState())
		try enterRule(_localctx, 50, WhereClauseGrammarParser.RULE_arithmetic_unary)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(262)
		 	_la = try _input.LA(1)
		 	if (!(//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.MINUS_SYMBOL.rawValue || _la == WhereClauseGrammarParser.Tokens.PLUS_SYMBOL.rawValue
		 	      return testSet
		 	 }())) {
		 	try _errHandler.recoverInline(self)
		 	}
		 	else {
		 		_errHandler.reportMatch(self)
		 		try consume()
		 	}
		 	setState(263)
		 	try arithmetic_expression(0)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Functions_returning_numericsContext: ParserRuleContext {
			open
			func LPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LPAREN.rawValue, 0)
			}
			open
			func string_primary() -> [String_primaryContext] {
				return getRuleContexts(String_primaryContext.self)
			}
			open
			func string_primary(_ i: Int) -> String_primaryContext? {
				return getRuleContext(String_primaryContext.self, i)
			}
			open
			func RPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.RPAREN.rawValue, 0)
			}
			open
			func COMMA_SYMBOL() -> [TerminalNode] {
				return getTokens(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
			}
			open
			func COMMA_SYMBOL(_ i:Int) -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue, i)
			}
			open
			func arithmetic_expression() -> [Arithmetic_expressionContext] {
				return getRuleContexts(Arithmetic_expressionContext.self)
			}
			open
			func arithmetic_expression(_ i: Int) -> Arithmetic_expressionContext? {
				return getRuleContext(Arithmetic_expressionContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_functions_returning_numerics
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterFunctions_returning_numerics(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitFunctions_returning_numerics(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitFunctions_returning_numerics(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitFunctions_returning_numerics(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func functions_returning_numerics() throws -> Functions_returning_numericsContext {
		var _localctx: Functions_returning_numericsContext = Functions_returning_numericsContext(_ctx, getState())
		try enterRule(_localctx, 52, WhereClauseGrammarParser.RULE_functions_returning_numerics)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(298)
		 	try _errHandler.sync(self)
		 	switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .T__0:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(265)
		 		try match(WhereClauseGrammarParser.Tokens.T__0.rawValue)
		 		setState(266)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(267)
		 		try string_primary()
		 		setState(268)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break

		 	case .T__1:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(270)
		 		try match(WhereClauseGrammarParser.Tokens.T__1.rawValue)
		 		setState(271)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(272)
		 		try string_primary()
		 		setState(273)
		 		try match(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
		 		setState(274)
		 		try string_primary()
		 		setState(277)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(275)
		 			try match(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
		 			setState(276)
		 			try arithmetic_expression(0)

		 		}

		 		setState(279)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break

		 	case .T__2:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(281)
		 		try match(WhereClauseGrammarParser.Tokens.T__2.rawValue)
		 		setState(282)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(283)
		 		try arithmetic_expression(0)
		 		setState(284)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break

		 	case .T__3:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(286)
		 		try match(WhereClauseGrammarParser.Tokens.T__3.rawValue)
		 		setState(287)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(288)
		 		try arithmetic_expression(0)
		 		setState(289)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break

		 	case .T__4:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(291)
		 		try match(WhereClauseGrammarParser.Tokens.T__4.rawValue)
		 		setState(292)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(293)
		 		try arithmetic_expression(0)
		 		setState(294)
		 		try match(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
		 		setState(295)
		 		try arithmetic_expression(0)
		 		setState(296)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Functions_returning_stringsContext: ParserRuleContext {
			open
			func LPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LPAREN.rawValue, 0)
			}
			open
			func string_primary() -> [String_primaryContext] {
				return getRuleContexts(String_primaryContext.self)
			}
			open
			func string_primary(_ i: Int) -> String_primaryContext? {
				return getRuleContext(String_primaryContext.self, i)
			}
			open
			func COMMA_SYMBOL() -> [TerminalNode] {
				return getTokens(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
			}
			open
			func COMMA_SYMBOL(_ i:Int) -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue, i)
			}
			open
			func RPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.RPAREN.rawValue, 0)
			}
			open
			func arithmetic_expression() -> [Arithmetic_expressionContext] {
				return getRuleContexts(Arithmetic_expressionContext.self)
			}
			open
			func arithmetic_expression(_ i: Int) -> Arithmetic_expressionContext? {
				return getRuleContext(Arithmetic_expressionContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_functions_returning_strings
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterFunctions_returning_strings(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitFunctions_returning_strings(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitFunctions_returning_strings(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitFunctions_returning_strings(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func functions_returning_strings() throws -> Functions_returning_stringsContext {
		var _localctx: Functions_returning_stringsContext = Functions_returning_stringsContext(_ctx, getState())
		try enterRule(_localctx, 54, WhereClauseGrammarParser.RULE_functions_returning_strings)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(331)
		 	try _errHandler.sync(self)
		 	switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .T__5:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(300)
		 		try match(WhereClauseGrammarParser.Tokens.T__5.rawValue)
		 		setState(301)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(302)
		 		try string_primary()
		 		setState(303)
		 		try match(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
		 		setState(304)
		 		try string_primary()
		 		setState(305)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break

		 	case .T__6:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(307)
		 		try match(WhereClauseGrammarParser.Tokens.T__6.rawValue)
		 		setState(308)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(309)
		 		try string_primary()
		 		setState(310)
		 		try match(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
		 		setState(311)
		 		try arithmetic_expression(0)
		 		setState(312)
		 		try match(WhereClauseGrammarParser.Tokens.COMMA_SYMBOL.rawValue)
		 		setState(313)
		 		try arithmetic_expression(0)
		 		setState(314)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break

		 	case .T__7:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(316)
		 		try match(WhereClauseGrammarParser.Tokens.T__7.rawValue)
		 		setState(317)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(318)
		 		try string_primary()
		 		setState(319)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break

		 	case .T__8:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(321)
		 		try match(WhereClauseGrammarParser.Tokens.T__8.rawValue)
		 		setState(322)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(323)
		 		try string_primary()
		 		setState(324)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break

		 	case .T__9:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(326)
		 		try match(WhereClauseGrammarParser.Tokens.T__9.rawValue)
		 		setState(327)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(328)
		 		try string_primary()
		 		setState(329)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Aggregate_expressionContext: ParserRuleContext {
			open
			func LPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LPAREN.rawValue, 0)
			}
			open
			func general_element() -> General_elementContext? {
				return getRuleContext(General_elementContext.self, 0)
			}
			open
			func RPAREN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.RPAREN.rawValue, 0)
			}
			open
			func id_expression() -> Id_expressionContext? {
				return getRuleContext(Id_expressionContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_aggregate_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterAggregate_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitAggregate_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitAggregate_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitAggregate_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func aggregate_expression() throws -> Aggregate_expressionContext {
		var _localctx: Aggregate_expressionContext = Aggregate_expressionContext(_ctx, getState())
		try enterRule(_localctx, 56, WhereClauseGrammarParser.RULE_aggregate_expression)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(352)
		 	try _errHandler.sync(self)
		 	switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .T__10:fallthrough
		 	case .T__11:fallthrough
		 	case .T__12:fallthrough
		 	case .T__13:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(333)
		 		_la = try _input.LA(1)
		 		if (!(//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = {  () -> Bool in
		 		   let testArray: [Int] = [_la, WhereClauseGrammarParser.Tokens.T__10.rawValue,WhereClauseGrammarParser.Tokens.T__11.rawValue,WhereClauseGrammarParser.Tokens.T__12.rawValue,WhereClauseGrammarParser.Tokens.T__13.rawValue]
		 		    return  Utils.testBitLeftShiftArray(testArray, 0)
		 		}()
		 		      return testSet
		 		 }())) {
		 		try _errHandler.recoverInline(self)
		 		}
		 		else {
		 			_errHandler.reportMatch(self)
		 			try consume()
		 		}
		 		setState(334)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(336)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.T__14.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(335)
		 			try match(WhereClauseGrammarParser.Tokens.T__14.rawValue)

		 		}

		 		setState(338)
		 		try general_element()
		 		setState(339)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break

		 	case .T__15:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(341)
		 		try match(WhereClauseGrammarParser.Tokens.T__15.rawValue)
		 		setState(342)
		 		try match(WhereClauseGrammarParser.Tokens.LPAREN.rawValue)
		 		setState(344)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.T__14.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(343)
		 			try match(WhereClauseGrammarParser.Tokens.T__14.rawValue)

		 		}

		 		setState(348)
		 		try _errHandler.sync(self)
		 		switch(try getInterpreter().adaptivePredict(_input,29, _ctx)) {
		 		case 1:
		 			setState(346)
		 			try id_expression()

		 			break
		 		case 2:
		 			setState(347)
		 			try general_element()

		 			break
		 		default: break
		 		}
		 		setState(350)
		 		try match(WhereClauseGrammarParser.Tokens.RPAREN.rawValue)

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class String_primaryContext: ParserRuleContext {
			open
			func quoted_string() -> Quoted_stringContext? {
				return getRuleContext(Quoted_stringContext.self, 0)
			}
			open
			func functions_returning_strings() -> Functions_returning_stringsContext? {
				return getRuleContext(Functions_returning_stringsContext.self, 0)
			}
			open
			func aggregate_expression() -> Aggregate_expressionContext? {
				return getRuleContext(Aggregate_expressionContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_string_primary
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterString_primary(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitString_primary(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitString_primary(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitString_primary(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func string_primary() throws -> String_primaryContext {
		var _localctx: String_primaryContext = String_primaryContext(_ctx, getState())
		try enterRule(_localctx, 58, WhereClauseGrammarParser.RULE_string_primary)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(357)
		 	try _errHandler.sync(self)
		 	switch (WhereClauseGrammarParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .CHAR_STRING:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(354)
		 		try quoted_string()

		 		break
		 	case .T__5:fallthrough
		 	case .T__6:fallthrough
		 	case .T__7:fallthrough
		 	case .T__8:fallthrough
		 	case .T__9:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(355)
		 		try functions_returning_strings()

		 		break
		 	case .T__10:fallthrough
		 	case .T__11:fallthrough
		 	case .T__12:fallthrough
		 	case .T__13:fallthrough
		 	case .T__15:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(356)
		 		try aggregate_expression()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class NumericContext: ParserRuleContext {
			open
			func UNSIGNED_INTEGER() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.UNSIGNED_INTEGER.rawValue, 0)
			}
			open
			func APPROXIMATE_NUM_LIT() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.APPROXIMATE_NUM_LIT.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_numeric
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterNumeric(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitNumeric(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitNumeric(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitNumeric(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func numeric() throws -> NumericContext {
		var _localctx: NumericContext = NumericContext(_ctx, getState())
		try enterRule(_localctx, 60, WhereClauseGrammarParser.RULE_numeric)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(359)
		 	_la = try _input.LA(1)
		 	if (!(//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.UNSIGNED_INTEGER.rawValue || _la == WhereClauseGrammarParser.Tokens.APPROXIMATE_NUM_LIT.rawValue
		 	      return testSet
		 	 }())) {
		 	try _errHandler.recoverInline(self)
		 	}
		 	else {
		 		_errHandler.reportMatch(self)
		 		try consume()
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Quoted_stringContext: ParserRuleContext {
			open
			func CHAR_STRING() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.CHAR_STRING.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_quoted_string
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterQuoted_string(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitQuoted_string(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitQuoted_string(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitQuoted_string(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func quoted_string() throws -> Quoted_stringContext {
		var _localctx: Quoted_stringContext = Quoted_stringContext(_ctx, getState())
		try enterRule(_localctx, 62, WhereClauseGrammarParser.RULE_quoted_string)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(361)
		 	try match(WhereClauseGrammarParser.Tokens.CHAR_STRING.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Like_quoted_stringContext: ParserRuleContext {
			open
			func CHAR_STRING() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.CHAR_STRING.rawValue, 0)
			}
			open
			func PERCENT_SYMBOL() -> [TerminalNode] {
				return getTokens(WhereClauseGrammarParser.Tokens.PERCENT_SYMBOL.rawValue)
			}
			open
			func PERCENT_SYMBOL(_ i:Int) -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.PERCENT_SYMBOL.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_like_quoted_string
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterLike_quoted_string(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitLike_quoted_string(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitLike_quoted_string(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitLike_quoted_string(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func like_quoted_string() throws -> Like_quoted_stringContext {
		var _localctx: Like_quoted_stringContext = Like_quoted_stringContext(_ctx, getState())
		try enterRule(_localctx, 64, WhereClauseGrammarParser.RULE_like_quoted_string)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(364)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.PERCENT_SYMBOL.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(363)
		 		try match(WhereClauseGrammarParser.Tokens.PERCENT_SYMBOL.rawValue)

		 	}

		 	setState(366)
		 	try match(WhereClauseGrammarParser.Tokens.CHAR_STRING.rawValue)
		 	setState(368)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == WhereClauseGrammarParser.Tokens.PERCENT_SYMBOL.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(367)
		 		try match(WhereClauseGrammarParser.Tokens.PERCENT_SYMBOL.rawValue)

		 	}


		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Comparison_operatorContext: ParserRuleContext {
			open
			func EQ_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.EQ_SYMBOL.rawValue, 0)
			}
			open
			func NE_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.NE_SYMBOL.rawValue, 0)
			}
			open
			func LT_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LT_SYMBOL.rawValue, 0)
			}
			open
			func GT_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.GT_SYMBOL.rawValue, 0)
			}
			open
			func LE_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LE_SYMBOL.rawValue, 0)
			}
			open
			func GE_SYMBOL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.GE_SYMBOL.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_comparison_operator
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterComparison_operator(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitComparison_operator(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitComparison_operator(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitComparison_operator(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func comparison_operator() throws -> Comparison_operatorContext {
		var _localctx: Comparison_operatorContext = Comparison_operatorContext(_ctx, getState())
		try enterRule(_localctx, 66, WhereClauseGrammarParser.RULE_comparison_operator)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(370)
		 	_la = try _input.LA(1)
		 	if (!(//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, WhereClauseGrammarParser.Tokens.EQ_SYMBOL.rawValue,WhereClauseGrammarParser.Tokens.GE_SYMBOL.rawValue,WhereClauseGrammarParser.Tokens.GT_SYMBOL.rawValue,WhereClauseGrammarParser.Tokens.LE_SYMBOL.rawValue,WhereClauseGrammarParser.Tokens.LT_SYMBOL.rawValue,WhereClauseGrammarParser.Tokens.NE_SYMBOL.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }())) {
		 	try _errHandler.recoverInline(self)
		 	}
		 	else {
		 		_errHandler.reportMatch(self)
		 		try consume()
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Id_expressionContext: ParserRuleContext {
			open
			func regular_id() -> [Regular_idContext] {
				return getRuleContexts(Regular_idContext.self)
			}
			open
			func regular_id(_ i: Int) -> Regular_idContext? {
				return getRuleContext(Regular_idContext.self, i)
			}
			open
			func DOT_SYMBOL() -> [TerminalNode] {
				return getTokens(WhereClauseGrammarParser.Tokens.DOT_SYMBOL.rawValue)
			}
			open
			func DOT_SYMBOL(_ i:Int) -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.DOT_SYMBOL.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_id_expression
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterId_expression(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitId_expression(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitId_expression(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitId_expression(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func id_expression() throws -> Id_expressionContext {
		var _localctx: Id_expressionContext = Id_expressionContext(_ctx, getState())
		try enterRule(_localctx, 68, WhereClauseGrammarParser.RULE_id_expression)
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(372)
		 	try regular_id()
		 	setState(377)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,34,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(373)
		 			try match(WhereClauseGrammarParser.Tokens.DOT_SYMBOL.rawValue)
		 			setState(374)
		 			try regular_id()

		 	 
		 		}
		 		setState(379)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,34,_ctx)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Regular_idContext: ParserRuleContext {
			open
			func REGULAR_ID() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.REGULAR_ID.rawValue, 0)
			}
			open
			func AND() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.AND.rawValue, 0)
			}
			open
			func OR() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.OR.rawValue, 0)
			}
			open
			func DISTANCE() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.DISTANCE.rawValue, 0)
			}
			open
			func FT() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.FT.rawValue, 0)
			}
			open
			func YD() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.YD.rawValue, 0)
			}
			open
			func MI() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.MI.rawValue, 0)
			}
			open
			func KM() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.KM.rawValue, 0)
			}
			open
			func M_WORD() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.M_WORD.rawValue, 0)
			}
			open
			func IN() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.IN.rawValue, 0)
			}
			open
			func LIKE() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LIKE.rawValue, 0)
			}
			open
			func NOT() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.NOT.rawValue, 0)
			}
			open
			func IS() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.IS.rawValue, 0)
			}
			open
			func NULL() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.NULL.rawValue, 0)
			}
			open
			func LATITUDE() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LATITUDE.rawValue, 0)
			}
			open
			func LONGITUDE() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.LONGITUDE.rawValue, 0)
			}
			open
			func TRUE() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.TRUE.rawValue, 0)
			}
			open
			func FALSE() -> TerminalNode? {
				return getToken(WhereClauseGrammarParser.Tokens.FALSE.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return WhereClauseGrammarParser.RULE_regular_id
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.enterRegular_id(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? WhereClauseGrammarListener {
				listener.exitRegular_id(self)
			}
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? WhereClauseGrammarVisitor {
			    return visitor.visitRegular_id(self)
			}
			else if let visitor = visitor as? WhereClauseGrammarBaseVisitor {
			    return visitor.visitRegular_id(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func regular_id() throws -> Regular_idContext {
		var _localctx: Regular_idContext = Regular_idContext(_ctx, getState())
		try enterRule(_localctx, 70, WhereClauseGrammarParser.RULE_regular_id)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(380)
		 	_la = try _input.LA(1)
		 	if (!(//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, WhereClauseGrammarParser.Tokens.AND.rawValue,WhereClauseGrammarParser.Tokens.DISTANCE.rawValue,WhereClauseGrammarParser.Tokens.FALSE.rawValue,WhereClauseGrammarParser.Tokens.FT.rawValue,WhereClauseGrammarParser.Tokens.IN.rawValue,WhereClauseGrammarParser.Tokens.IS.rawValue,WhereClauseGrammarParser.Tokens.KM.rawValue,WhereClauseGrammarParser.Tokens.LATITUDE.rawValue,WhereClauseGrammarParser.Tokens.LIKE.rawValue,WhereClauseGrammarParser.Tokens.LONGITUDE.rawValue,WhereClauseGrammarParser.Tokens.M_WORD.rawValue,WhereClauseGrammarParser.Tokens.MI.rawValue,WhereClauseGrammarParser.Tokens.NOT.rawValue,WhereClauseGrammarParser.Tokens.NULL.rawValue,WhereClauseGrammarParser.Tokens.OR.rawValue,WhereClauseGrammarParser.Tokens.TRUE.rawValue,WhereClauseGrammarParser.Tokens.YD.rawValue,WhereClauseGrammarParser.Tokens.REGULAR_ID.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 41)
		 	}()
		 	      return testSet
		 	 }())) {
		 	try _errHandler.recoverInline(self)
		 	}
		 	else {
		 		_errHandler.reportMatch(self)
		 		try consume()
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	override open
	func sempred(_ _localctx: RuleContext?, _ ruleIndex: Int,  _ predIndex: Int)throws -> Bool {
		switch (ruleIndex) {
		case  23:
			return try arithmetic_expression_sempred(_localctx?.castdown(Arithmetic_expressionContext.self), predIndex)
	    default: return true
		}
	}
	private func arithmetic_expression_sempred(_ _localctx: Arithmetic_expressionContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 0:return precpred(_ctx, 4)
		    case 1:return precpred(_ctx, 3)
		    default: return true
		}
	}


	public
	static let _serializedATN = WhereClauseGrammarParserATN().jsonString

	public
	static let _ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}

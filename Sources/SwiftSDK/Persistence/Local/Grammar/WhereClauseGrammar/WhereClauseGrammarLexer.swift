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

open class WhereClauseGrammarLexer: Lexer {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = WhereClauseGrammarLexer._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(WhereClauseGrammarLexer._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	static let T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, 
            T__8=9, T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, 
            T__15=16, AMP_SYMBOL=17, AMPAMP_SYMBOL=18, CARET_SYMBOL=19, 
            COMMA_SYMBOL=20, DOT_SYMBOL=21, COMMENT_SYMBOL=22, CONTINUATION_SYMBOL=23, 
            EQ_SYMBOL=24, GE_SYMBOL=25, GT_SYMBOL=26, LE_SYMBOL=27, LT_SYMBOL=28, 
            MINUS_SYMBOL=29, NE_SYMBOL=30, PLUS_SYMBOL=31, STAR_SYMBOL=32, 
            SLASH_SYMBOL=33, PERCENT_SYMBOL=34, LSQ_BRACKET=35, RSQ_BRACKET=36, 
            SINGLE_QUOTE_SYMBOL=37, LPAREN=38, RPAREN=39, AFTER=40, AND=41, 
            AT=42, BEFORE=43, DISTANCE=44, ESCAPE=45, FALSE=46, FT=47, IN=48, 
            IS=49, KM=50, LATITUDE=51, LIKE=52, LONGITUDE=53, M_WORD=54, 
            MI=55, NOT=56, NULL=57, OR=58, TRUE=59, YD=60, UNSIGNED_INTEGER=61, 
            APPROXIMATE_NUM_LIT=62, CHAR_STRING=63, DELIMITED_ID=64, SPACES=65, 
            REGULAR_ID=66, ZV=67

	public
	static let channelNames: [String] = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	public
	static let modeNames: [String] = [
		"DEFAULT_MODE"
	]

	public
	static let ruleNames: [String] = [
		"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "T__7", "T__8", 
		"T__9", "T__10", "T__11", "T__12", "T__13", "T__14", "T__15", "AMP_SYMBOL", 
		"AMPAMP_SYMBOL", "CARET_SYMBOL", "COMMA_SYMBOL", "DOT_SYMBOL", "COMMENT_SYMBOL", 
		"CONTINUATION_SYMBOL", "EQ_SYMBOL", "GE_SYMBOL", "GT_SYMBOL", "LE_SYMBOL", 
		"LT_SYMBOL", "MINUS_SYMBOL", "NE_SYMBOL", "PLUS_SYMBOL", "STAR_SYMBOL", 
		"SLASH_SYMBOL", "PERCENT_SYMBOL", "LSQ_BRACKET", "RSQ_BRACKET", "SINGLE_QUOTE_SYMBOL", 
		"LPAREN", "RPAREN", "AFTER", "AND", "AT", "BEFORE", "DISTANCE", "ESCAPE", 
		"FALSE", "FT", "IN", "IS", "KM", "LATITUDE", "LIKE", "LONGITUDE", "M_WORD", 
		"MI", "NOT", "NULL", "OR", "TRUE", "YD", "A", "B", "C", "D", "E", "F", 
		"G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", 
		"U", "V", "W", "X", "Y", "Z", "UNSIGNED_INTEGER", "APPROXIMATE_NUM_LIT", 
		"CHAR_STRING", "DELIMITED_ID", "SPACES", "SIMPLE_LETTER", "UNSIGNED_INTEGER_FRAGMENT", 
		"FLOAT_FRAGMENT", "NEWLINE", "SPACE", "REGULAR_ID", "ZV"
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
	func getVocabulary() -> Vocabulary {
		return WhereClauseGrammarLexer.VOCABULARY
	}

	public
	required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.7.1", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, WhereClauseGrammarLexer._ATN, WhereClauseGrammarLexer._decisionToDFA, WhereClauseGrammarLexer._sharedContextCache)
	}

	override open
	func getGrammarFileName() -> String { return "WhereClauseGrammar.g4" }

	override open
	func getRuleNames() -> [String] { return WhereClauseGrammarLexer.ruleNames }

	override open
	func getSerializedATN() -> String { return WhereClauseGrammarLexer._serializedATN }

	override open
	func getChannelNames() -> [String] { return WhereClauseGrammarLexer.channelNames }

	override open
	func getModeNames() -> [String] { return WhereClauseGrammarLexer.modeNames }

	override open
	func getATN() -> ATN { return WhereClauseGrammarLexer._ATN }


	public
	static let _serializedATN: String = WhereClauseGrammarLexerATN().jsonString

	public
	static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}

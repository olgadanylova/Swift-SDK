grammar WhereClauseGrammar;

@header {
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
}
import Lexer;

expression
    : logical_and_expression ( OR logical_and_expression )*
    ;

logical_and_expression
    : negated_expression ( AND negated_expression )*
    ;

negated_expression
    : NOT negated_expression
    | relational_expression
    ;

relational_expression
    : in_expression
    | geo_expression
    | boolean_expression
    | null_comparison_expression
    | string_expression
    | arithmetic_comparison_expression
    | datetime_expression
    | parenthed_expression
    ;

parenthed_expression
    : LPAREN expression RPAREN
    ;

in_expression
    : general_element (NOT? (IN LPAREN in_elements RPAREN))
    ;

in_elements
    : (quoted_string | numeric) (COMMA_SYMBOL (quoted_string | numeric) )*
    ;

boolean_expression
    : general_element boolean_operator ( TRUE | FALSE )
    ;

arithmetic_comparison_expression
    : arithmetic_expression comparison_operator arithmetic_expression
    ;

string_expression
    : general_element comparison_operator simple_string_expression                      #stringComparisonExpression
    | general_element (NOT? (LIKE quoted_string like_escape_part?))                     #stringLikeExpression
    ;

like_escape_part
    : ESCAPE simple_string_expression
    ;

simple_string_expression
    : general_element
    | quoted_string
    | functions_returning_strings
    ;

null_comparison_expression
    : general_element boolean_operator NULL
    ;

boolean_operator
    : equal = ( EQ_SYMBOL | IS )
    | ( NE_SYMBOL | IS NOT )
    ;

datetime_expression
    : general_element datetime_operator timestamp
    ;

datetime_operator
    : AT
    | AFTER
    | BEFORE
    | AT OR AFTER
    | AT OR BEFORE
    ;

timestamp
    : numeric
    | quoted_string
    ;

general_element
    : (inverse_relation)* id_expression
    ;

inverse_relation
    : parentTable=regular_id LSQ_BRACKET relationColumn=regular_id RSQ_BRACKET DOT_SYMBOL
    ;

geo_expression
    : distance_func comparison_operator units_function
    ;

distance_func
   : DISTANCE LPAREN
        distance_arg COMMA_SYMBOL distance_arg COMMA_SYMBOL
        distance_arg COMMA_SYMBOL distance_arg
        RPAREN
   ;

distance_arg
   : (MINUS_SYMBOL)? numeric
   | general_element
   ;

units_function
   : unit=(FT | KM | MI | YD ) LPAREN numeric RPAREN
   | numeric
   ;

arithmetic_expression
   : arithmetic_expression operation=(STAR_SYMBOL | SLASH_SYMBOL) arithmetic_expression #multiplication
   | arithmetic_expression operation=(PLUS_SYMBOL | MINUS_SYMBOL) arithmetic_expression #addition
   | LPAREN arithmetic_expression RPAREN                                                #arithmeticParenthed
   | arithmetic_primary                                                                 #arithmeticPrimary
   ;

arithmetic_primary
   : general_element
   | numeric
   | functions_returning_numerics
   | aggregate_expression
   | arithmetic_unary
   ;

arithmetic_unary
   : (PLUS_SYMBOL | MINUS_SYMBOL) arithmetic_expression
   ;

functions_returning_numerics
   : 'LENGTH' LPAREN string_primary RPAREN
   | 'LOCATE' LPAREN string_primary COMMA_SYMBOL string_primary (COMMA_SYMBOL arithmetic_expression)? RPAREN
   | 'ABS' LPAREN arithmetic_expression RPAREN
   | 'SQRT' LPAREN arithmetic_expression RPAREN
   | 'MOD' LPAREN arithmetic_expression COMMA_SYMBOL arithmetic_expression RPAREN
   ;

functions_returning_strings
   : 'CONCAT' LPAREN string_primary COMMA_SYMBOL string_primary RPAREN
   | 'SUBSTRING' LPAREN string_primary COMMA_SYMBOL arithmetic_expression COMMA_SYMBOL arithmetic_expression RPAREN
   | 'TRIM' LPAREN string_primary RPAREN
   | 'LOWER' LPAREN string_primary RPAREN
   | 'UPPER' LPAREN string_primary RPAREN
   ;

aggregate_expression
   : ('AVG' | 'MAX' | 'MIN' | 'SUM') LPAREN ('DISTINCT')? general_element RPAREN
   | 'COUNT' LPAREN ('DISTINCT')? (id_expression | general_element ) RPAREN
   ;

string_primary
   : quoted_string
   | functions_returning_strings
   | aggregate_expression
   ;


// $<Lexer Mappings

numeric
    : UNSIGNED_INTEGER
    | APPROXIMATE_NUM_LIT
    ;

quoted_string
    : CHAR_STRING
    ;

like_quoted_string
    : PERCENT_SYMBOL? CHAR_STRING PERCENT_SYMBOL?
    ;

comparison_operator: ( EQ_SYMBOL | NE_SYMBOL | LT_SYMBOL | GT_SYMBOL | LE_SYMBOL | GE_SYMBOL );

id_expression
    : regular_id (DOT_SYMBOL regular_id)*
    ;

//should be enumerated all upper-case words in grammar
regular_id
    : REGULAR_ID
    | AND
    | OR
    | DISTANCE
    | FT
    | YD
    | MI
    | KM
    | M_WORD
    | IN
    | LIKE
    | NOT
    | IS
    | NULL
    | LATITUDE
    | LONGITUDE
    | TRUE
    | FALSE
    ;


/////////////////////////////////////////////
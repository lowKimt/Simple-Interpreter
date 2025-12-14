module tokens;

/*

INT

PLUS
MINUS
MUL
DIV
MOD

LPAREN
RPAREN

ILLEGAL
EOF

*/

struct Token {
    String type;
    String literal;
}
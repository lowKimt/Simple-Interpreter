module lexer;
import std::io;
import std::core::string;
import tokens;

struct Lexer {
    String input;
    int pos;
    char current_char;
}

fn Lexer new_Lexer(String input) {
    Lexer l;
    l.input = input;
    l.pos = 0;
    l.current_char = input[l.pos];
    return l;
}

fn void Lexer.advance(Lexer* self) {
    self.pos++;
    if (self.pos >= self.input.len) {
        self.current_char = 0;
    } else {
        self.current_char = self.input[self.pos];
    }
}

fn String Lexer.integer(Lexer* self) {
    DString result;
    while (self.current_char >= '0' && self.current_char <= '9') {
        result.append_char(self.current_char);
        self.advance();
    }
    return result.tcopy_str();
}

fn tokens::Token Lexer.next_token(Lexer* self) {
    while WHITESPACE_CHECK: (self.current_char != 0) {
        while (self.current_char == ' ' 
            || self.current_char == '\t' 
            || self.current_char == '\n' 
            || self.current_char == '\r') {
            self.advance();
            continue WHITESPACE_CHECK;
        }

        if (self.current_char >= '0' && self.current_char <= '9') {
            String value = self.integer();
            return (tokens::Token){
                "INT",
                value,
            };
        }

        switch (self.current_char) {
        case '+':
            self.advance();
            return (tokens::Token){
                "PLUS",
                "+",
            };
        case '-':
            self.advance();
            return (tokens::Token){
                "MINUS",
                "-",
            };
        case '*':
            self.advance();
            return (tokens::Token){
                "MUL",
                "*",
            };
        case '/':
            self.advance();
            return (tokens::Token){
                "DIV",
                "/",
            };
        case '%':
            self.advance();
            return (tokens::Token){
                "MOD",
                "%",
            };
        case '(': 
            self.advance();
            return (tokens::Token){
                "LPAREN",
                "(",
            };
        case ')':
            self.advance();
            return (tokens::Token){
                "RPAREN",
                ")",
            };
        default:
            return (tokens::Token){
                "ILLEGAL",
                "",
            };
        }
    }
    return (tokens::Token){
        "EOF",
        "",
    };
}
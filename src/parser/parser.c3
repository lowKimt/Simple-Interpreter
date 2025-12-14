import ast;
import lexer;
import tokens;
import std::core::mem::allocator;

faultdef INVALID_TOKEN_TYPE;

struct Parser 
{
    Allocator allocator;
    Lexer *lexer;
    Token curToken;
}

fn Parser new_Parser(Lexer *lexer) 
{
    Parser p;
    p.allocator = allocator::mem;
    p.lexer = lexer;
    p.curToken = lexer.next_token();
    return p;
}

fn void? Parser.eat(Parser* self, String token_type) {
    if (self.curToken.type == token_type) 
    {
        self.curToken = self.lexer.next_token();
        return;
    } else {
        return INVALID_TOKEN_TYPE?;
    }
}

fn ast::Node? Parser.factor(Parser *self) 
{
    switch (self.curToken.type) 
    {
    case "INT":
        int resint = self.curToken.literal.to_int() ?? INVALID_TOKEN_TYPE?!;
        self.eat("INT")!;
        return allocator::new(self.allocator, Integer, { .value = resint });
    
    case "LPAREN":
        self.eat("LPAREN")!;
        ast::Node node = self.expr()!;
        self.eat("RPAREN")!;
        return allocator::new(self.allocator, ast::ParenExpr, { .expr = node });

    default:
        return INVALID_TOKEN_TYPE?;
    }
}

fn ast::Node? Parser.term(Parser *self) 
{
    Node left = self.factor()!;

    while (self.curToken.type == "MUL" 
        || self.curToken.type == "DIV" 
        || self.curToken.type == "MOD") 
    {
        Token op = self.curToken;
        if (op.type == "MUL") 
        {
            self.eat("MUL")!;
        } else if (op.type == "DIV") 
        {
            self.eat("DIV")!;
        } else 
        {
            self.eat("MOD")!;
        }
        Node right = self.factor()!;
        BinOp *result = allocator::new(self.allocator, ast::BinOp);
        result.l = left;
        result.op = op.literal;
        result.r = right;
        left = result;
    }

    return left;
}

fn ast::Node? Parser.expr(Parser *self) {
    Node left = self.term()!;

    while (self.curToken.type == "PLUS" 
        || self.curToken.type == "MINUS") 
    {
        Token op = self.curToken;
        if (op.type == "PLUS") 
        {
            self.eat("PLUS")!;
        } else 
        {
            self.eat("MINUS")!;
        }
        Node right = self.term()!;
        BinOp *result = allocator::new(self.allocator, ast::BinOp);
        result.l = left;
        result.op = op.literal;
        result.r = right;
        left = result;
    }

    return left;
}
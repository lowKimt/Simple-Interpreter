import parser;
import lexer;
import ast;

fn void test_Addition() @test 
{
    Lexer lex = lexer::new_Lexer("1 + 1");
    Parser parser = parser::new_Parser(&lex);
    ast::BinOp *node = (BinOp*)parser.expr()!!;
    Integer* left = (Integer*)node.l;
    Integer* right = (Integer*)node.r;
    assert(node.op == "+", "Operator should be +");
    assert(left.value == 1, "Left value should be 1");
    assert(right.value == 1, "Right value should be 1");

    node.free(mem);
}

fn void test_Subtraction() @test 
{
    Lexer lex = lexer::new_Lexer("1 - 1");
    Parser parser = parser::new_Parser(&lex);
    ast::BinOp *node = (BinOp*)parser.expr()!!;
    Integer* left = (Integer*)node.l;
    Integer* right = (Integer*)node.r;
    assert(node.op == "-", "Operator should be -");
    assert(left.value == 1, "Left value should be 1");
    assert(right.value == 1, "Right value should be 1");

    node.free(mem);
}

fn void test_Multiplication() @test 
{
    Lexer lex = lexer::new_Lexer("1 * 1");
    Parser parser = parser::new_Parser(&lex);
    ast::BinOp *node = (BinOp*)parser.expr()!!;
    Integer* left = (Integer*)node.l;
    Integer* right = (Integer*)node.r;
    assert(node.op == "*", "Operator should be *");
    assert(left.value == 1, "Left value should be 1");
    assert(right.value == 1, "Right value should be 1");

    node.free(mem);
}

fn void test_Division() @test 
{
    Lexer lex = lexer::new_Lexer("1 / 1");
    Parser parser = parser::new_Parser(&lex);
    ast::BinOp *node = (BinOp*)parser.expr()!!;
    Integer* left = (Integer*)node.l;
    Integer* right = (Integer*)node.r;
    assert(node.op == "/", "Operator should be /");
    assert(left.value == 1, "Left value should be 1");
    assert(right.value == 1, "Right value should be 1");

    node.free(mem);
}

fn void test_Modulo() @test 
{
    Lexer lex = lexer::new_Lexer("1 % 1");
    Parser parser = parser::new_Parser(&lex);
    ast::BinOp *node = (BinOp*)parser.expr()!!;
    Integer* left = (Integer*)node.l;
    Integer* right = (Integer*)node.r;
    assert(node.op == "%", "Operator should be %");
    assert(left.value == 1, "Left value should be 1");
    assert(right.value == 1, "Right value should be 1");

    node.free(mem);
}

fn void test_Paren() @test
{
    Lexer lex = lexer::new_Lexer("(1)");
    Parser parser = parser::new_Parser(&lex);
    ast::ParenExpr *node = (ParenExpr*)parser.expr()!!;
    Integer* expr = (Integer*)node.expr;
    assert(expr.value == 1, "Value should be 1");

    node.free(mem);
}

fn void test_Comprehensive() @test
{
    
}
import interpreter;
import parser;
import lexer;
import ast;

fn void test_interpret_addition() @test 
{
    Lexer lex = lexer::new_Lexer("1 + 1");
    Parser parser = parser::new_Parser(&lex);
    ast::Node node = parser.expr()!!;
    
    int result = interpreter::visit(node)!!;
    assert(result == 2, "1 + 1 should equal 2");
    
    // Don't forget to free!
    node.free(mem);
}

fn void test_interpret_sub() @test
{
    Lexer lex = lexer::new_Lexer("1 - 1");
    Parser parser = parser::new_Parser(&lex);
    ast::Node node = parser.expr()!!;
    
    int result = interpreter::visit(node)!!;
    assert(result == 0, "1 - 1 should equal 0");
    
    // Don't forget to free!
    node.free(mem);

}

fn void test_interpret_mul() @test
{
    Lexer lex = lexer::new_Lexer("1 * 1");
    Parser parser = parser::new_Parser(&lex);
    ast::Node node = parser.expr()!!;
    
    int result = interpreter::visit(node)!!;
    assert(result == 1, "1 * 1 should equal 1");
    
    // Don't forget to free!
    node.free(mem);
}

fn void test_interpret_div() @test
{
    Lexer lex = lexer::new_Lexer("1 / 1");
    Parser parser = parser::new_Parser(&lex);
    ast::Node node = parser.expr()!!;
    
    int result = interpreter::visit(node)!!;
    assert(result == 1, "1 / 1 should equal 1");
    
    // Don't forget to free!
    node.free(mem);
}

fn void test_interpret_mod() @test
{
    Lexer lex = lexer::new_Lexer("1 % 1");
    Parser parser = parser::new_Parser(&lex);
    ast::Node node = parser.expr()!!;
    
    int result = interpreter::visit(node)!!;
    assert(result == 0, "1 % 1 should equal 0");
    
    // Don't forget to free!
    node.free(mem);
}

fn void test_interpret_paren() @test 
{
    Lexer lex = lexer::new_Lexer("(1)");
    Parser parser = parser::new_Parser(&lex);
    ast::Node node = parser.expr()!!;
    
    int result = interpreter::visit(node)!!;
    assert(result == 1, "(1) should equal 1");
    
    // Don't forget to free!
    node.free(mem);
}

fn void test_interpret_comprehensive() @test 
{
    Lexer lex = lexer::new_Lexer("5 + (2 - 3) * 7 % (16 / 2)");
    Parser parser = parser::new_Parser(&lex);
    ast::Node node = parser.expr()!!;
    
    int result = interpreter::visit(node)!!;
    assert(result == 6, "5 + (2 - 3) * 7 % (16 / 2) should equal 6");
    
    // Don't forget to free!
    node.free(mem);
}
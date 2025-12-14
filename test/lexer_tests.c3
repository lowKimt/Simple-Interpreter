import lexer;
import std::io;
import std::core::mem::allocator;
import std::collections::list;
import tokens;

fn void test_int() @test 
{
    list::List {Token} tokens;
    tokens.init(mem);

    Lexer l;
    String input = "1";
    l = lexer::new_Lexer(input);
    for (int i = 0; i < input.len; i++) 
    {
        tokens.push(l.next_token());

        if (try tok = tokens.last()) 
        {
            if (tok.type == "EOF") break;
        }
    }
    assert(tokens[0].type == "INT", "Token should be INT");
    tokens.free();
}

fn void test_multiple_int() @test 
{
    list::List {Token} tokens;
    tokens.init(mem);

    Lexer l;
    String input = "11 6 8";
    
    l = lexer::new_Lexer(input);
    for (int i = 0; i < input.len; i++) 
    {
        tokens.push(l.next_token());

        if (try tok = tokens.last()) 
        {
            if (tok.type == "EOF") break;
        }
    }
    assert(tokens[0].type == "INT", "Token should be INT");
    assert(tokens[0].literal == "11", "Token literal should be 11");
    assert(tokens[1].type == "INT", "Token should be INT");
    assert(tokens[1].literal == "6", "Token literal should be 6");
    assert(tokens[2].type == "INT", "Token should be INT");
    assert(tokens[2].literal == "8", "Token literal should be 8");
    tokens.free();
}

fn void test_ops() @test {
    list::List {Token} tokens;
    tokens.init(mem);

    Lexer l;
    String input = "+ - * / %";
    
    l = lexer::new_Lexer(input);
    for (int i = 0; i < input.len; i++) 
    {
        tokens.push(l.next_token());

        if (try tok = tokens.last()) 
        {
            if (tok.type == "EOF") break;
        }
    }
    assert(tokens[0].type == "PLUS", "Token should be PLUS");
    assert(tokens[1].type == "MINUS", "Token should be MINUS");
    assert(tokens[2].type == "MUL", "Token should be MUL");
    assert(tokens[3].type == "DIV", "Token should be DIV");
    assert(tokens[4].type == "MOD", "Token should be MOD");
    tokens.free();
}

fn void test_parens() @test 
{
    list::List {Token} tokens;
    tokens.init(mem);

    Lexer l;
    String input = "( )";
    
    l = lexer::new_Lexer(input);
    for (int i = 0; i < input.len; i++) 
    {
        tokens.push(l.next_token());

        if (try tok = tokens.last()) 
        {
            if (tok.type == "EOF") break;
        }
    }
    assert(tokens[0].type == "LPAREN", "Token should be LPAREN");
    assert(tokens[1].type == "RPAREN", "Token should be RPAREN");
    tokens.free();
}

fn void test_comprehensive() @test 
{
    list::List {Token} tokens;
    tokens.init(mem);

    Lexer l;
    String input = "1 + 1 * 1 / 1 % 1 - 1 + (1)";
    
    l = lexer::new_Lexer(input);
    for (int i = 0; i < input.len; i++) 
    {
        tokens.push(l.next_token());

        if (try tok = tokens.last())
         {
            if (tok.type == "EOF") break;
        }
    }
    
    String[] expected_types = {
        "INT", "PLUS", "INT", "MUL", "INT", "DIV", "INT", "MOD", "INT", "MINUS", "INT", "PLUS", "LPAREN", "INT", "RPAREN"
    };

    for (int i = 0; i < expected_types.len; i++) 
    {
        assert(tokens[i].type == expected_types[i], "Token type mismatch");
    }

    tokens.free();
}
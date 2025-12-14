import parser;
import ast;
import lexer;
import interpreter;

import std::io;

fn void repl() 
{
    while (1) @pool() 
    {
        io::print("cmd: ");
        String? input = io::treadline();

        if (catch input) continue;
        
        Lexer lex = lexer::new_Lexer(input);
        Parser parser = parser::new_Parser(&lex);
        ast::Node? node = parser.expr();

        if (catch node) continue;

        defer node.free(mem);

        int? result = interpreter::visit(node);
        if (catch result) continue;

        io::printn(result);
    };
}

fn void main() 
{
    repl();
}

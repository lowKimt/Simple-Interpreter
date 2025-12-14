import parser;
import ast;
import lexer;
import interpreter;

import std::io;

fn void repl() 
{
    String input;
    while (1) {
        io::print("cmd: ");
        if (try in = io::readline(mem)) 
        {
            input = in;

            Lexer lex = lexer::new_Lexer(input);
            Parser parser = parser::new_Parser(&lex);
            ast::Node? node = parser.expr();

            if (catch err = node) 
            {
                io::printn(err);
                continue;
            }

            defer node.free(mem);

            int? result = interpreter::visit(node);
            if (catch err = result) 
            {
                io::printn(err);
                continue;
            }

            io::printn(result);
        }
    }
}

fn void main() 
{
    repl();
}

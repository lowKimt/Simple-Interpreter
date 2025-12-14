module interpreter;

import helper;
import ast;

faultdef INVALID_NODE_TYPE;

fn int? visit(ast::Node node)
{
    switch (node.type) {
    case ast::BinOp:
        return visit_binop((BinOp*)node);
    case ast::Integer:
        return visit_integer((Integer*)node);
    case ast::ParenExpr:
        return visit_parenexpr((ParenExpr*)node);
    default:
        return INVALID_NODE_TYPE?;
    }
}

fn int visit_binop(ast::BinOp* node) 
{
    BinOp *binop = node;
    int left = visit(binop.l)!!;
    int right = visit(binop.r)!!;
    switch (binop.op) 
    {
    case "+":
        return left + right;
    case "-":
        return left - right;
    case "*":
        return left * right;
    case "/":
        return left / right;
    case "%":
        // Python-like modulo for now
        return helper::py_mod(left, right);
    default:
        return 0;
    }
}

fn int visit_integer(ast::Integer* node) 
{
    return node.value;
}

fn int visit_parenexpr(ast::ParenExpr* node) 
{
    return visit(node.expr)!!;
}
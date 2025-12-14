module ast;

interface Node
{
    fn void isNode();
    fn void free(Allocator allocator);
}

interface Expression : Node
{
    fn void isExpression();
}
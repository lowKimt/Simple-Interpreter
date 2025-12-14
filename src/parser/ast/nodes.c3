module ast;

struct Integer (Node) 
{
    int value;
}

fn void Integer.isNode(Integer* self) @dynamic {}
fn void Integer.free(Integer* self, Allocator allocator) @dynamic
{
    allocator::free(allocator, self);
}

struct BinOp (Expression) 
{
    Node l;
    Node r;
    String op;
}

fn void BinOp.isExpression(BinOp* self) @dynamic {}
fn void BinOp.isNode(BinOp* self) @dynamic {}
fn void BinOp.free(BinOp* self, Allocator allocator) @dynamic
{
    self.l.free(allocator);
    self.r.free(allocator);
    allocator::free(allocator, self);
}

struct ParenExpr (Expression) 
{
    Node expr;
}

fn void ParenExpr.isExpression(ParenExpr* self) @dynamic {}
fn void ParenExpr.isNode(ParenExpr* self) @dynamic {}
fn void ParenExpr.free(ParenExpr* self, Allocator allocator) @dynamic
{
    self.expr.free(allocator);
    allocator::free(allocator, self);
}
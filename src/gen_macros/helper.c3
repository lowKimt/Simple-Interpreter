macro py_mod(a, b)
{
    int r = a % b;
    return (r != 0 && (r < 0) != (b < 0)) ? r + b : r;
}

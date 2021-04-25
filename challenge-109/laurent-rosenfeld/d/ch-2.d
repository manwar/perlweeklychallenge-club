bool check_squares (int [] p) {
    int sum = p[0] + p[1];
    return ( p[1] + p[2] + p[3] == sum &&
        p[3] + p[4] + p[5] == sum &&
        p[5] + p[6] == sum);
}

void main() {
    import std.stdio, std.algorithm;
    auto items = [1, 2, 3, 4, 5, 6, 7];
    do
        if (check_squares(items)) items.writeln;
    while (items.nextPermutation);
}

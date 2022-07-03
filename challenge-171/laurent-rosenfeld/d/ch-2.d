import std.stdio;

T delegate(S) compose(T, U, S)(in T delegate(U) f,
                               in U delegate(S) g) {
    return s => f(g(s));
}

void main() {
    auto h = compose((int x) => x / 2 + 1, (int x) => x * 2);
    for (int i = 1; i <= 6; i++) {
        writeln(i);
    }
}

import std.stdio;
import std.bigint;

void main() {
    BigInt s = "2";
    writeln(s);
    for (int i = 1; i <= 9; i++) {
        s = s * (s - 1) + 1;
        writeln(s);
    }
}

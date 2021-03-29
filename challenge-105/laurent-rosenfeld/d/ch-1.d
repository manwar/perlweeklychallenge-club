import std.stdio;
import std.math;

void main() {
    auto input = 248832;
    for (int i = 1; i <= 8; i++) {
        double root = pow(input, 1.0/i);
        writeln(i, "     ", root);
    }
}

import std.stdio;
import std.math;
import std.conv;

bool is_esthetic(int num) {
    auto s = to!string(num, 10);
    foreach (i; 1 .. s.length) {
        if (abs(s[i] - s[i-1]) != 1) return false;
    }
    return true;
}
void main() {
    int[] tests = [ 5456, 120, 121, 23456, 2346, 7654567, 765467 ];
    foreach(test; tests) {
        printf("%-9d ", test);
        if (is_esthetic(test)) {
            writeln("is esthetic");
        } else {
            writeln("is not esthetic");
        }
    }
}

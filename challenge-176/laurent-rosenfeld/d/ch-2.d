import std.stdio;
import std.conv, std.range;

bool is_reversible(int n) {
    string s = to!string(n, 10);
    string rev = s.retro.text;
    string sum = to!string(n + to!int(rev), 10);
    for (int k = 0; k < sum.length; k++) {
        if (sum[k] % 2 == 0) {
            return false;
        }
    }
    return true;
}

void main() {
    for (int i = 1; i < 100; i++) {
        if (is_reversible(i)) {
            printf("%d ", i);
        }
    }
    writeln(" ");
}

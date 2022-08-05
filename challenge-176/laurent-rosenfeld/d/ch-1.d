import std.stdio;
import std.conv, std.array;
import std.algorithm;

int normalize(int num) {
    string n = to!string(num, 10);
    ulong len = n.length;
    string[] d = n.split("");
    d.sort();
    return to!int(d.joiner);
}

bool permuted_multiples (int n) {
    int norm_in = normalize(n);
    for (int i = 6; i > 2; i--)
        if (normalize(n * i) != norm_in) return false;
    return true;
}

void main() {
    int i = 1;
    while (true) {
        if (permuted_multiples(i)) {
            printf("%d\n", i);
            break;
        }
        i++;
    }
    writeln(" ");
}

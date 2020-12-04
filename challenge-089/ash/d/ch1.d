// How to run:
// $ rdmd ch1.d 100
// 13015

import std.stdio;
import std.numeric;
import std.conv;

void main(string[] args) {
    auto n = args.length == 2 ? to!int(args[1]) : 3;
    
    auto s = 0;
    for (auto x = 1; x <= n; x++) {
        for (auto y = x + 1; y <= n; y++) {
            s += gcd(x, y);
        }
    }

    writeln(s);
}

#!/usr/bin/env raku

# Test run:
# $ raku ch-1.raku 100
# 13015

my $n = @*ARGS[0] // 3;

say [+] (1..$n).combinations(2).map: {[gcd] $_};

# Test: perl6 ch-1.p6 3 4
sub MAIN(Int $n, Int $k) {
    [1 .. $n].permutations[$k - 1].join.say;
}

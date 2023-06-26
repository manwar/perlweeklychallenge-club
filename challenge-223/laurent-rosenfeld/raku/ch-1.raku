sub count-primes ($n) {
    return ((1..$n).grep({.is-prime})).elems;
}
for 10, 1, 20 -> $test {
    say $test.fmt("%-3d => "), count-primes $test;
}

#!/usr/bin/perl6

multi sub ackermann (
    Int $m where { $m == 0 },
    Int $n where { $n >= 0 },
) {
    return $n + 1;
}

multi sub ackermann (
    Int $m where { $m >= 0 },
    Int $n where { $n == 0 },
) {
    return ackermann($m - 1, 1);
}

multi sub ackermann (
    Int $m where { $m >= 0 },
    Int $n where { $n >= 0 },
) {
    return ackermann($m - 1, ackermann($m, $n - 1));
}

say ackermann(1, 2);

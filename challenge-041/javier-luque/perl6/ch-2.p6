# Test: perl6 ./ch-2.p6
use v6.d;

sub MAIN () {
    my @leonardo = 1, 1, * + * + 1 ... *;
    say "L($_) = " ~ @leonardo[$_]
        for (1 .. 20);
}

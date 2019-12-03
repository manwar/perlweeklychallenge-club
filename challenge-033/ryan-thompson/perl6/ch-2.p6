#!/usr/bin/env perl6

# challenge-033/ch-2.p6 - Print multiplication table
#
# Ryan Thompson <rjt@cpan.org>

use v6;

sub MAIN(Int $max = 11) {
    my $w     = ($max*$max).chars;  # Maximum width in table
    my $fmt   = "%{$w}s";           # Evenly sized columns
    my @n     = 1..$max;            # Trivial to change this to, say, primes

    ('',       ' | ', @n                                    ).fmt($fmt).say;
    ('-' x $w, '-+-', '-' x $w xx $max                      ).fmt($fmt).say;

    for @n -> $n {
        ($n,   ' | ', @n.map: { $n > $^m ?? '' !! $n * $^m }).fmt($fmt).say;
    }
}

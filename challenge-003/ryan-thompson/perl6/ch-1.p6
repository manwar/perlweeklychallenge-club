#!/usr/bin/env perl6

# ch-1.p6 - Generate 5-smooth (Hamming) numbers
#
# Ryan Thompson <rjt@cpan.org>

use v6;

my Int $lim = 10000;

sub MAIN( Int $limit ) {
    hamming($limit).join(', ').say;
}

#| Return Hamming numbers up to the specified $limit
sub hamming( Int $limit ) {
    my @n;
    for 1, 2, 4, 8 … ∞ -> $d2 {
        last if $d2 > $limit;
        for 1, 3, 9, 27 … ∞ -> $d3 {
            last if $d2 * $d3 > $limit;
            for 1, 5, 25, 125 … ∞ -> $d5 {
                my $n = $d2 * $d3 * $d5;
                last if $n > $limit;
                @n.push($n);
            }
        }
    }

    @n.sort;
}

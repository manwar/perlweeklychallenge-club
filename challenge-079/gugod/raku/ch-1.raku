#!/usr/bin/env raku

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
# TASK #1 › Count Set Bits
#
#     raku ./ch-1.raku 4
#     5 % 1000000007 = 5
#

sub count_set_bits(Int $n is copy) {
    my Int $c = 0;
    while $n > 0 {
        $c += ($n % 2);
        $n div= 2;
    }
    return $c;
}

sub MAIN(Int $N) {
    my $total = 0;
    for 1..$N -> $n {
        my $c = count_set_bits($n);
        $total += $c;
    }
    say "{{ $total }} % 1000000007 = " ~ ( $total % 1000000007 );
}

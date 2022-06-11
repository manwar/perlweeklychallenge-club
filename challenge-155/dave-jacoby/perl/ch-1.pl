#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use List::Util qw{ product uniq };

my $c = 1;
my @fortune;
my @prime;

OUTER: while ( $c < 40 && scalar @fortune < 8 ) {
    $c++;
    if ( is_prime($c) ) {
        push @prime, $c;
        my $p = product @prime;
        my $d = 1;
        while ( $d < 50 ) {
            $d++;
            my $f  = $p + $d;
            my $is = is_prime($f);
            if ($is) {
                # the non-sorted, non-unique list of the first 
                # eight fortunate numbers contains 23 twice, so
                # 1) we need to accomodate that possibility by
                #   starting each $d back at 2, and 
                # 2) we need to remove it before the outer while
                #   loop accounts for it
                # so that's why $d=1 in the while loop and
                # why we don't just push $d
                @fortune = uniq sort { $a <=> $b } @fortune, $d;
                next OUTER;
            }
        }
    }
}
say 'FORTUNATE NUMBERS: ' . join ', ', @fortune;

# using my is_prime rather than Abigail's, because that
# one was giving me "too much recursion" errors.
sub is_prime ($n) {
    for ( 2 .. sqrt $n ) { return 0 unless $n % $_ }
    return 1;
}

#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

my @examples = ( [ 8, 24 ], [ 26, 39 ], [ 4, 10 ], [ 24, 40 ] );

for my $i (@examples) {
    my ( $m, $n ) = $i->@*;
    my $o = two_friendly( $i->@* );
    say <<"END";
    Input: \$m = $m \$n = $n
    Output: $o
END
}

# "Two-Friendly" means the greatest common
# denominator is a power of two.

# Greatest common denomonator is the product
# of all the common denominators. 

# So, the moment you get a common denominator 
# that is NOT zero, you have a two-unfriendly
# number and can securely return 0
sub two_friendly ( $m = 8, $n = 16 ) {
    my ($lower) = sort { $a <=> $b } $m, $n;
    for my $i ( 2 .. $lower ) {
        while ( $m % $i == 0 && $n % $i == 0 ) {
            $m /= $i;
            $n /= $i;
            return 0 if $i != 2;
        }
    }
    return 1;
}

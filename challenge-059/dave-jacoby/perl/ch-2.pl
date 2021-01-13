#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

use List::Util qw{ sum };
use Algorithm::Combinatorics 'combinations';

use JSON;
my $json = JSON->new->canonical->allow_nonref;

say f2();
say f2(1);
say f2( 1, 3 );
say f2( 2, 3, 4 );
say f2( 2, 3, 4, 5 );
say f2( 99,101 );

# if array has < 2 entries, return 0 because there's not enough
# to work with.
# use combinations to get all possible combinations of n vals
#   - for example, w/ 1,2,3: [1,2],[1,3],[2,3]
sub f2 ( @array ) {
    return 0 if scalar @array < 2;
    my $sum = 0;
    for my $combo ( combinations( \@array, 2 ) ) {
        my $f = f( $combo->@* );
        $sum += $f;
    }
    return $sum;
}

# back to front:
#   $i ^ $j - XOR, which is $i or $j but not $i and $j
#   sprintf - make a string representation of a
#               binary number of the result
#   split // - turn '00001111' into [0,0,0,0,1,1,1,1]
#   sum     - add all the numbers in the array together
sub f ( $i, $j ) {
    return sum split //, sprintf '%b', $i ^ $j;
}


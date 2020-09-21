#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

#  You are given array @A containing positive numbers and @B containing one or
#  more indices from the array @A.
#
#  Write a script to left rotate @A so that the number at the first index of @B
#  becomes the first element in the array. Similary, left rotate @A again so
#  that the number at the second index of @B becomes the first element in the
#  array.

my @A = ( 10, 20, 30, 40, 50 );
my @B = ( 3, 4 );

for my $index (@B) {
    say '[' . join( ', ', left_rotate( $index, @A ) ) . ']';
}

sub left_rotate ( $index, @array ) {
    while ( $index-- ) {
        my $top = shift @array;
        push @array, $top;
    }

    return @array;
}

#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

# You are given array @A containing positive numbers
# and @B containing one or more indices from the array @A.

# Write a script to left rotate @A so that the number
# at the first index of @B becomes the first element
# in the array. Similary, left rotate @A again so that
# the number at the second index of @B becomes the first
# element in the array.

#       and this is where you look into the examples to tell,
#       because by description, I would've thought that you
#       work again on the modified array, not starting over

my $o1 = left_rotation( [ 10, 20, 30, 40, 50 ], [ 3, 4 ] );
my $o2 = left_rotation( [ 7, 4, 2, 6, 3 ], [ 1, 3, 4 ] );

for my $o ( $o1, $o2 ) {
    for my $r ( $o->@* ) {
        print '[';
        print join ' ', $r->@*;
        say ']';
    }
    say '';
}

# Example 1
# [40 50 10 20 30]
# [50 10 20 30 40]

# Example 2
# [4 2 6 3 7]
# [6 3 7 4 2]
# [3 7 4 2 6]

sub left_rotation ( $nums, $indices ) {
    my @output;
    for my $i ( $indices->@* ) {
        my @new = $nums->@*;
        for ( 1 .. $i ) {
            push @new, shift @new;
        }
        push @output, [@new];
    }

    push @output, 0 unless scalar @output;
    return wantarray ? @output : \@output;
}

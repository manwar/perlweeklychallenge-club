#!/usr/bin/env perl
# TASK #1 › Leader Element
# Submitted by: Mohammad S Anwar
#
# You are given an array @A containing distinct integers.
#
# Write a script to find all leader elements in the array @A. Print (0) if none found.
#
#     An element is leader if it is greater than all the elements to its right side.
#
# Example 1:
#
#     Input: @A = (9, 10, 7, 5, 6, 1)
#     Output: (10, 7, 6, 1)
#
# Example 2:
#
#     Input: @A = (3, 4, 5)
#     Output: (5)
#
use strict;
use warnings;
use Test::More;
use feature qw/ say /;

my @E1I = ( 9,  10, 7, 5, 6, 1 );
my @E1O = ( 10, 7,  6, 1 );
my @E2I = ( 3,  4,  5 );
my @E2O = (5);
my @E3I = ();
my @E3O = (0);

is_deeply( get_leader_elements( \@E1I ), \@E1O );
is_deeply( get_leader_elements( \@E2I ), \@E2O );
is_deeply( get_leader_elements( \@E3I ), \@E3O );
done_testing();

sub get_leader_elements {
    my $array_ref = shift;
    my @array     = @{$array_ref};
    my @leader_elements;
    say "Input: \@A = (", join( ", ", @array ), ")";
    if ( scalar @array == 0 ) {
        @leader_elements = (0);
    }
    else {
        my $max = pop @array;
        push @leader_elements, $max;
        for ( reverse @array ) {
            if ( $_ > $max ) {
                push @leader_elements, $_;
                $max = $_;
            }
        }
    }
    @leader_elements = reverse @leader_elements;
    say "Output: (", join( ", ", @leader_elements ), ")";
    return \@leader_elements;
}

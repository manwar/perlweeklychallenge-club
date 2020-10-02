#!/usr/bin/env perl
# Solution by Steven Wilson 2nd Oct 2020.

# TASK #1 › Smallest Positive Number
# Submitted by: Mohammad S Anwar
#
# You are given unsorted list of integers @N.
#
# Write a script to find out the smallest positive number missing.
# Example 1:
#
# Input: @N = (5, 2, -2, 0)
# Output: 1
#
# Example 2:
#
# Input: @N = (1, 8, -1)
# Output: 2
#
# Example 3:
#
# Input: @N = (2, 0, -1)
# Output: 1

use strict;
use warnings;
use feature qw/ say /;
use Test::More;
use List::MoreUtils qw/ firstidx /;

my @N1_t = ( 5, 2, -2, 0 );
my @N2_t = ( 1, 8, -1 );
my @N3_t = ( 2, 0, -1 );
my @N4_t = ( 5, 2, -2, 0, 1, 3, 4, 6 );
my @N5_t = ();
ok( get_smallest_positive_number_missing( \@N1_t ) == 1, "1 missing" );
ok( get_smallest_positive_number_missing( \@N2_t ) == 2, "1 present" );
ok( get_smallest_positive_number_missing( \@N3_t ) == 1, "1 missing" );
ok( get_smallest_positive_number_missing( \@N4_t ) == 7, "larger than max" );
ok( get_smallest_positive_number_missing( \@N5_t ) == 1, "empty list" );
done_testing();

sub get_smallest_positive_number_missing {
    my $unsorted_list_ref = shift;
    my @sorted_list       = sort { $a <=> $b } @{$unsorted_list_ref};
    my $index             = firstidx { $_ == 1 } @sorted_list;
    my $answer            = 1;
    if ( $index >= 0 ) {
        my $counter = 1;
        while ( defined $sorted_list[ $index + ( $counter - 1 ) ]
            && $sorted_list[ $index + ( $counter - 1 ) ] == ($counter) )
        {
            $counter++;
        }
        $answer = $counter;
    }
    return $answer;
}


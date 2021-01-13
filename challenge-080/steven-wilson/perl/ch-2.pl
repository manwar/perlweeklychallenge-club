#!/usr/bin/env perl
# Solution by Steven Wilson 3rd Oct 2020.

# TASK #2 › Count Candies
# Submitted by: Mohammad S Anwar
#
# You are given rankings of @N candidates.
#
# Write a script to find out the total candies needed for all
# candidates. You are asked to follow the rules below:
# a) You must given at least one candy to each candidate.
# b) Candidate with higher ranking get more candies than their
# mmediate neighbors on either side.
# Example 1:
#
# Input: @N = (1, 2, 2)
#
# Explanation:
#
# Applying rule #a, each candidate will get one candy. So total
# candies needed so far 3. Now applying rule #b, the first candidate
# do not get any more candy as its rank is lower than it's
# neighbours. The second candidate gets one more candy as it's
# ranking is higher than it's neighbour. Finally the third candidate
# do not get any extra candy as it's ranking is not higher than
# neighbour. Therefore total candies required is 4.
#
# Output: 4
#
# Example 2:
#
# Input: @N = (1, 4, 3, 2)
#
# Explanation:
#
# Applying rule #a, each candidate will get one candy. So total
# candies needed so far 4. Now applying rule #b, the first candidate
# do not get any more candy as its rank is lower than it's
# neighbours. The second candidate gets two more candies as it's
# ranking is higher than it's both neighbour. The third candidate
# gets one more candy as it's ranking is higher than it's neighbour.
# Finally the fourth candidate do not get any extra candy as it's
# ranking is not higher than neighbour. Therefore total candies
# required is 7.
#
# Output: 7
#

use strict;
use warnings;
use feature qw/ say /;
use Test::More;
use List::Util qw/ sum /;

my @N1_t = ( 1, 2, 2 );
my @N2_t = ( 1, 4, 3, 2 );
my @N3_t = ( 1, 1, 2, 3 );
my @N4_t = ( 3, 1, 2, 1 );
ok( get_total_candies( \@N1_t ) == 4, "example 1" );
ok( get_total_candies( \@N2_t ) == 7, "example 2" );
ok( get_total_candies( \@N3_t ) == 7, "last ranking higher" );
ok( get_total_candies( \@N4_t ) == 6, "first ranking higher" );
done_testing();

sub get_total_candies {
    my $rankings_ref    = shift;
    my @rankings        = @{$rankings_ref};
    my @candies         = map { 1 } 1 .. scalar @rankings;
    my $candies_changed = 1;
    while ($candies_changed) {
        $candies_changed = 0;
        for my $i ( 0 .. ( scalar @rankings - 2 ) ) {
            if ( $rankings[$i] > $rankings[ $i + 1 ]
                && !( $candies[$i] > $candies[ $i + 1 ] ) )
            {
                $candies[$i]++;
                $candies_changed = 1;
            }
            elsif ( $rankings[$i] < $rankings[ $i + 1 ]
                && !( $candies[$i] < $candies[ $i + 1 ] ) )
            {
                $candies[ $i + 1 ]++;
                $candies_changed = 1;
            }
        }
    }
    return sum @candies;
}


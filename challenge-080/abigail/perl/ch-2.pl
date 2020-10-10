#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';


#
#
# Challenge 2:
#
#   You are given rankings of @N candidates.
#
#   Write a script to find out the total candies needed for all candidates.
#   You are asked to follow the rules below:
#     a) You must given at least one candy to each candidate.
#     b) Candidate with higher ranking get more candies than their immediate
#        neighbors on either side.
#

#
# Note:
#
#   - It is not given that rankings are positive integers, or even integers.
#     They may be reals.
#
#   - The number of candies handed out is twice the number of candidates
#     minus 1, minus the number of pairs of consecutive candidates with
#     the same ranking.
#
#     We can easily see this by looking at each consecutive pair of 
#     candidates. If their rankings are unequal, exactly one of them
#     gets an extra candy. If the rankings are the same, none of them
#     gets an extra candy. Since we have N - 1 such pairs, and every
#     candidate gets at least once candy, the total number of candies
#     is 2 * N - 1, minus the number of consecutive candidates with the
#     same ranking.
#
#     This, of course, is the same as N plus the number of consecutive
#     pairs with different rankings.
#


while (<>) {
    #
    # Read a line of input, split on whitespace, and put the results
    # in an array @N. Initialize the number of candies to the number
    # of candidates.
    #
    my $candies = my @N = split;

    #
    # Add a candy of each pair of consecutive candidates with different
    # rankings.
    #
    $N [$_] == $N [$_ + 1] || $candies ++ for 0 .. @N - 2;

    say $candies;
}

__END__

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
#   - Each candidate gets 1, 2, or 3 candies. If a candidates ranking is
#     higher than each of its neighbours, it gets 3 candies. If its ranking
#     is higher than only on of its neighbours, it gets 2 candies. Else, it
#     gets 1 candy.
#
#   - It is not given that rankings are positive integers, or even integers.
#     They may be reals.
#


while (<>) {
    my $candies = 0;
    #
    # Read a line of input, split on whitespace, and put the results
    # in an array @N.
    #
    my @N = split ' ';

    #
    # Iterate over the array, and count the candies.
    #
    foreach my $i (keys @N) {
        $candies ++;
        $candies ++ if $i > 0   && $N [$i] > $N [$i - 1];
        $candies ++ if $i < $#N && $N [$i] > $N [$i + 1];
    }

    say $candies;
}

__END__

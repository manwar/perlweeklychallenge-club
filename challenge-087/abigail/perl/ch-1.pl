#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

#
# Challenge
#
# You are given an unsorted array of integers @N.
#
# Write a script to find the longest consecutive sequence. Print 0 if
# none sequence found.
#

#
# Notes:
#   - The challenge itself doesn't say what sequences we are looking for.
#     The examples suggest we're looking for sequences where the next
#     element in the sequence is one more than the previous.
#
#   - One example contradicts the challenge. It suggests that the output
#     for an input of "(20, 30, 10, 40, 50)" should be 0. Despite the
#     array containing 5 sequences of length 1.
#     We could do one of four things:
#        a) Consider the example containing a typo, the output should
#           have been 10 (or 20, 30, 40, or 50).
#        b) Special case the array "(20, 30, 10, 40, 50)", and do the
#           right thing for any other array.
#        c) Only print the longest sequence if there is no other sequence
#           with the same length.
#        d) Print 0 if the longest sequence is 1.
#
# We pick option d), because we think that was probably indended. 
#
# Challenges where the examples clearly contradict the challenge 
# are just confusing, and don't make for a fun one.
#

use experimental 'signatures';
use experimental 'lexical_subs';

while (<>) {
    #
    # Read in the data
    #
    my @array = sort {$a <=> $b} /-?[0-9]+/g;

    #
    # Special case the empty array
    #
#   say (0), next unless @array;

    #
    # Iterate over the array, track streaks of increasing numbers.
    # Also track the longest streak, and the index of where the
    # longest streak ends. Note that we count starting from 0.
    #
    my $max_streak = 0;
    my $max_index  = 0;
    my $cur_streak = 0;

    for (my $i = 1; $i < @array; $i ++) {
        if ($array [$i] == $array [$i - 1] + 1) {
            if (++ $cur_streak > $max_streak) {
                $max_streak = $cur_streak;
                $max_index  = $i;
            }
        }
        else {
            $cur_streak = 0;
        }
    }

    #
    # Print the longest sequence, except if the longest sequence
    # has length 1. Then we just print 0.
    #
    say $max_streak ? join ", " => @array [$max_index - $max_streak ..
                                           $max_index]
                    : 0;
}

__END__

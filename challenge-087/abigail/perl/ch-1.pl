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

#
# A naive solution would sort the array, and then look for consecutive
# sequences. But then you'd have to deal with duplicates (that is,
# if @N = (2, 7, 3, 9, 4, 8, 4, 5), the solution should be (2, 3, 4, 5)),
# and, most of all, you'd be inefficient, spending Omega (N log N) time,
# as sorting the numbers dominates.
#
# Instead, we repeatedly pick a random number from our set, and find
# the longest sequence it is part off. We then compare this sequence
# to the best found so far, updating the best one if necessary. We then
# remove the sequence from the set, and if the set isn't empty, we repeat.
#
# This is a linear expected time algorithm. Building a hash takes linear
# time, and then every element is added to a sequence once, and deleted
# from the hash once. Both operations can be done in constant time.
#

use experimental 'signatures';
use experimental 'lexical_subs';

while (<>) {
    #
    # Read in the data
    #
    my %set = map {$_ => 1} /-?[0-9]+/g;

    my @best = (0, 0);
    while (%set) {
        keys %set;                       # Reset iterator.
        my $low = my $high = each %set;  # Random entry.
        #
        # Extend the sequence downwards and upwards as
        # much as possible.
        #
        $low  -- while $set {$low  - 1};
        $high ++ while $set {$high + 1};

        #
        # Update the best sequence so far.
        #
        @best = ($low, $high) if
                 $low < $high &&   # Exclude sequences of length 1
                 $high - $low > $best [1] - $best [0];

        #
        # Delete sequence from set.
        #
        delete @set {$low .. $high};
    }

    #
    # Print the result.
    #
    local $, = ", ";
    say $best [0] .. $best [1];
}


__END__

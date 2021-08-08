#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use List::Util qw [sum];

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

#
# This is an NP-hard problem. So, we aren't going to bother with
# a smart algorithm -- we'll just try every possible partition of
# the appropriate sizes.
# (Using dynamic programming would be a better algorithm, but
# it would still be exponential in the worst case).
#

#
# We'll read sets from standard input, expecting a set per line of
# input, with the numbers separated by whitespace.
# For each line of output, we write one line of output, with the two
# sets separated by a semi-colon.
#

use POSIX      qw [floor ceil];
use List::Util qw [sum0];

{
    my $best_diff = ~0;
    my @best_set1;
    my @best_set2;

    #
    # Initialize the bookkeeping.
    #
    sub init () {
        $best_diff = ~0;  # Max int
    }

    #
    # Given two sets, find the difference of their sums.
    # If better than what we have seen so far, record this.
    #
    sub check_sets ($set1, $set2) {
        my $diff = abs (sum (@$set1) - sum (@$set2));
        if ($diff < $best_diff) {
            $best_diff = $diff;
            @best_set1 = @$set1;
            @best_set2 = @$set2;
        }
    }

    #
    # Print the results
    #
    sub report {
        say "@best_set1; @best_set2";
    }
}


#
# Split $set into two sets of (almost) equal size. If either of the
# two sets has the desired size, add the remaineder of $set to the
# other, and perform a check for the best result.
#
# Else, get the next element from $set, and add it to $set1 and $set2,
# and recurse.
#
sub split_set ($set, $set1, $set2, $callback) {
    my $n = @$set + @$set1 + @$set2;

    if (@$set1 == floor ($n / 2)) {
        $callback -> ($set1, [@$set2, @$set]);
    }
    elsif (@$set2 == ceil ($n / 2)) {
        $callback -> ([@$set1, @$set], $set2);
    }
    else {
        my $element = $$set [0];
        split_set ([@$set [1 .. $#$set]], [@$set1, $element], $set2, $callback);
        split_set ([@$set [1 .. $#$set]], $set1, [@$set2, $element], $callback);
    }
}

#
# Read input, split, and report the best split.
#
while (<>) {
    init ();
    split_set ([split], [], [], \&check_sets);
    report ();
}


__END__

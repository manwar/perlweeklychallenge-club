#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# "You are given a list of intervals".
#
# Uhm, what's the domain? Which dimension, and from which set are the
# the coordinates? N? Z? Q? R? C? Something else?
#
# The examples given have 1-d intervals, with positive integer coordinates,
# so we'll assume we only have positive integer coordinates, and our
# intervals are 1-d.
#
# "Write a script to find out if the current interval conflicts with
#  any of the previous intervals."
#
# This suggest we should output a true/false value. Or perhaps multiple.
# What is "the current interval"? The first one? The last one? 
# The examples aren't very useful, as it prints out some of the 
# intersection intervals, leaving out others.
#
# Did noone proofread the challenge?
#
# We'll just going to assume 1 should be printed if there is a pair of
# intervals which intersect, and 0 otherwise.
#

#
# The best solution would be to build an interval tree, which can be
# done in O (n log n) time, and for each of the intervals, check if
# it intersects with any of the others. The latter can be done in 
# O (log n) time for each interval, which would give an O (n log n)
# solution. However, we'll do the easy thing: just compare each pair
# of intervals, stopping as soon as we have an intersecting pair.
# Worst case there are no intersections, and we're doing O (n^2)
# comparisons (each of them can be done in O (1) time).
#

#
# Run as: perl ch-1.pl < input-file
#

#
# Return true if two intervals intersect, false otherwise.
#
my sub intersects ($x, $y) {($$x [1] >= $$y [0]) && ($$x [0] <= $$y [1])}

MAIN: while (<>) {
    my @intervals = map {[split /[^0-9]+/]} /[1-9][0-9]*[^0-9]+[1-9][0-9]*/g;

    #
    # Make sure the intervals are all in order, that is, have their
    # first vertex < second vertex.
    #
    foreach my $interval (@intervals) {
        @$interval = reverse @$interval if $$interval [1] < $$interval [0];
    }

    # 
    # Compare each pair of intervals
    #

    for (my $i = 1; $i < @intervals; $i ++) {
        for (my $j = 0; $j < $i; $j ++) {
            if (intersects $intervals [$i], $intervals [$j]) {
                say 1;
                next MAIN;
            }
        }
    }
    say 0;
}

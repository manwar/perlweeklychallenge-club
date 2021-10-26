#!/usr/bin/env perl

# TASK #2 > Conflict Intervals
# Submitted by: Mohammad S Anwar
# You are given a list of intervals.
#
# Write a script to find out if the current interval conflicts with any of the
# previous intervals.
#
# Example
# Input: @Intervals = [ (1,4), (3,5), (6,8), (12, 13), (3,20) ]
# Output: [ (3,5), (3,20) ]
#
#     - The 1st interval (1,4) do not have any previous intervals to compare
#       with, so skip it.
#     - The 2nd interval (3,5) does conflict with previous interval (1,4).
#     - The 3rd interval (6,8) do not conflicts with any of the previous intervals
#       (1,4) and (3,5), so skip it.
#     - The 4th interval (12,13) again do not conflicts with any of the previous
#       intervals (1,4), (3,5) and (6,8), so skip it.
#     - The 5th interval (3,20) conflicts with the first interval (1,4).
#
# Input: @Intervals = [ (3,4), (5,7), (6,9), (10, 12), (13,15) ]
# Output: [ (6,9) ]
#
#     - The 1st interval (3,4) do not have any previous intervals to compare
#       with, so skip it.
#     - The 2nd interval (5,7) do not conflicts with the previous interval (3,4),
#       so skip it.
#     - The 3rd interval (6,9) does conflict with one of the previous intervals (5,7).
#     - The 4th interval (10,12) do not conflicts with any of the previous
#       intervals (3,4), (5,7) and (6,9), so skip it.
#     - The 5th interval (13,15) do not conflicts with any of the previous
#       intervals (3,4), (5,7), (6,9) and (10,12), so skip it.

use Modern::Perl;

my @intervals = parse_intervals(@ARGV);
my @conflicts = find_conflicts(@intervals);
print_conflicts(@conflicts);


sub parse_intervals {
    my(@in) = @_;
    my @out;
    while (@in) {
        my($s, $e) = splice(@in, 0, 2);
        push @out, [$s, $e];
    }
    return @out;
}

sub find_conflicts {
    my(@intervals) = @_;
    my @conflicts;
    for my $i (1 .. $#intervals) {
        for my $j (0 .. $i-1) {
            my $i1s = $intervals[$i][0];
            my $i1e = $intervals[$i][1];
            my $i2s = $intervals[$j][0];
            my $i2e = $intervals[$j][1];
            if (($i1s >= $i2s && $i1s <  $i2e) ||
                ($i1e >= $i2s && $i1e <  $i2e) ||
                ($i1s <  $i2s && $i1e >= $i2e)) {
                push @conflicts, $intervals[$i];
                last;
            }
        }
    }

    return @conflicts;
}

sub print_conflicts {
    my(@conflicts) = @_;
    use Data::Dump 'dump';
    print "[ ";
    my $sep = "";
    for (@conflicts) {
        my($s, $e) = @$_;
        print $sep,"($s,$e)";
        $sep = ", ";
    }
    print " ]\n";
}

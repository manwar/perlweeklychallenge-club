#!/usr/bin/perl

# Challenge 092
#
# TASK #2 › Insert Interval
# Submitted by: Mohammad S Anwar
# You are given a set of sorted non-overlapping intervals and a new interval.
#
# Write a script to merge the new interval to the given set of intervals.
#
# Example 1:
# Input $S = (1,4), (8,10); $N = (2,6)
# Output: (1,6), (8,10)
# Example 2:
# Input $S = (1,2), (3,7), (8,10); $N = (5,8)
# Output: (1,2), (3,10)
# Example 3:
# Input $S = (1,5), (7,9); $N = (10,11)
# Output: (1,5), (7,9), (10,11)

use strict;
use warnings;
use 5.030;

my @intervals;          # set of all intervals
add_interval(parse($_)) for @ARGV;
print_intervals();

# convert a string "(a,b)" into [a,b]
sub parse {
    my($text) = @_;
    my($a, $b) = ($text =~ /(\d+)\D+(\d+)/) or die "invalid interval: $text\n";
    return ($a, $b);
}

# add a new interval in order, merge if overlapping
sub add_interval {
    my($s, $e) = @_;
    add_interval_1(sort {$a <=> $b} ($s, $e));
    merge_intervals();
}

sub add_interval_1 {
    my($a, $b) = @_;
    if (!@intervals) {                      # first interval
        push @intervals, [$a, $b];
    }
    else {
        for (my $i = 0; $i < @intervals; $i++) {
            my $this = $intervals[$i];
            if ($b < $this->[0]) {                          # before, not overlapping
                splice(@intervals, $i, 0, [$a, $b]);
                return;
            }
            elsif ($b >= $this->[0] && $b < $this->[1]) {   # end within this interval
                if ($a < $this->[0]) {                      # merge start
                    $this->[0] = $a;
                }
                return;
            }
            elsif ($b >= $this->[1] && $a < $this->[1]) {   # end after inteval, start within
                $this->[1] = $b;
                if ($a < $this->[0]) {                      # merge start
                    $this->[0] = $a;
                }
                return;
            }
        }
        push @intervals, [$a, $b];                          # append to end
    }
}

sub merge_intervals {
    for (my $i = 0; $i+1 < @intervals; $i++) {
        while ($i+1 < @intervals) {
            my $this = $intervals[$i];
            my $next = $intervals[$i+1];
            if ($this->[1] < $next->[0]) {                  # not overlapping
                last;                                       # next interval
            }
            else {
                splice(@intervals, $i, 2, [$this->[0], $next->[1]]);    # merge and test again
            }
        }
    }
}

sub print_intervals {
    say join(", ", map {"(".$_->[0].",".$_->[1].")"} @intervals);
}

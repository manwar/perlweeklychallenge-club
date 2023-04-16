#!/usr/bin/perl
use strict;
use warnings;

sub merge_intervals {
    my @intervals = @_;
    @intervals = sort { $a->[0] <=> $b->[0] } @intervals;

    my @merged_intervals;
    my $current_interval = $intervals[0];

    for (my $i = 1; $i < scalar @intervals; $i++) {
        if ($current_interval->[1] >= $intervals[$i]->[0]) {
            $current_interval->[1] = $intervals[$i]->[1] if $current_interval->[1] < $intervals[$i]->[1];
        } else {
            push @merged_intervals, $current_interval;
            $current_interval = $intervals[$i];
        }
    }
    push @merged_intervals, $current_interval;

    return \@merged_intervals;
}

my @intervals = (
    [2, 7],
    [3, 9],
    [10, 12],
    [15, 19],
    [18, 22],
);

my $merged_intervals = merge_intervals(@intervals);
print "Merged intervals: ";
foreach my $interval (@{$merged_intervals}) {
    print "[" . $interval->[0] . ", " . $interval->[1] . "] ";
}
print "\n";


#!/usr/bin/perl

use strict;
use warnings;

my $intervals = [ [2,7], [3,9], [10,12], [15,19], [18,22] ];

my $k;
my $m;

foreach my $interval (@$intervals) {
    my $i = $interval->[0];
    next if (defined $k && ($k == $i));

    my ($j, $_k) = merge_interval($interval->[1], $intervals);
    push @$m, [$i, $j];

    $k = $_k;
}

print_intervals("Original", $intervals);
print_intervals("Merged", $m);

#
#
# METHODS

sub merge_interval {
    my ($j, $intervals) = @_;

    my $_j = $j;
    my $_i;
    foreach my $i (@$intervals) {
        if ($i->[0] <= $j) {
            $_j = $i->[1];
            $_i = $i->[0];
        }
    }

    return ($_j, $_i);
}

sub print_intervals {
    my ($key, $m) = @_;

    print "$key: [";
    foreach (@$m) {
        print sprintf(" [%d, %d]", $_->[0], $_->[1]);
    }
    print " ]\n";
}

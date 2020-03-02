#!/usr/bin/perl

use strict;
use warnings;

my $o = [ [2,7], [3,9], [10,12], [15,19], [18,22] ];
my $k;
my $m;

foreach my $interval (@$o) {
    my $i = $interval->[0];
    next if (defined $k && ($k == $i));

    my ($j, $_k) = merge_intervals($interval->[1], $o);
    push @$m, [$i, $j];

    $k = $_k;
}

print_intervals("Original", $o);
print_intervals("Merged", $m);

#
#
# METHODS

sub merge_intervals {
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
    my ($key, $intervals) = @_;

    print "$key: [";
    foreach (@$intervals) {
        print sprintf(" [%d, %d]", $_->[0], $_->[1]);
    }
    print " ]\n";
}

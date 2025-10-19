#!/usr/bin/perl
use strict;
use warnings;

sub distance_to_zero {
    my @nums = @_;

    if (grep { $_ == 0 } @nums) {
        print "Values closest to 0: 0 (distance = 0)\n";
        print "Exact zero wins regardless of other close values.\n";
        return 0;
    }

    my $min_distance;
    foreach my $num (@nums) {
        my $abs_val = abs($num);
        if (!defined $min_distance || $abs_val < $min_distance) {
            $min_distance = $abs_val;
        }
    }

    my @closest = grep { abs($_) == $min_distance } @_;

    print 'Values closest to 0: '
        . join(' and ', @closest)
        . ' (distance = '
        . join(' and ', map { abs($_) } @closest)
        . ")\n";

    return $min_distance;
}

my @tests = (
    [4, 2, -1, 3, -2],
    [-5, 5, -3, 3, -1, 1],
    [7, -3, 0, 2, -8],
    [-2, -5, -1, -8],
    [-2, 2, -4, 4, -1, 1],
);

foreach my $case (@tests) {
    print "Input: \@nums = (" . join(', ', @$case) . ")\n";
    print 'Output: ' . distance_to_zero(@$case) . "\n\n";
}

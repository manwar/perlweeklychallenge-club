#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;
use Test::Deep;

cmp_deeply( merge_intervals( [ [1, 12], [7, 8], [12, 14], [15, 19] ]),
            [ [1, 14], [15, 19] ] );
cmp_deeply( merge_intervals( [ [2,7], [3,9], [10,12], [15,19], [18,22] ]),
            [ [2, 9], [10, 12], [15, 22] ] );

#
#
# METHODS

sub merge_intervals {
    my ($intervals) = @_;

    my $k;
    my $l;
    my $m;

    foreach my $interval (@$intervals) {
        my $i = $interval->[0];

        next if (defined $l &&
                 defined $k &&
                 (($i <= $l) || ($k == $i)));

        my ($j, $_k) = _merge_intervals($interval->[1], $intervals);
        push @$m, [$i, $j];

        $k = $_k;
        $l = $j;
    }

    return $m;
}

sub _merge_intervals {
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

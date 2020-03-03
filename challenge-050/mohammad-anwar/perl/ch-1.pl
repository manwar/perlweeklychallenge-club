#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 8;
use Test::Deep;

cmp_deeply( merge_intervals( [ [1, 12], [7, 8], [12, 14], [15, 19] ] ),
            [ [1, 14], [15, 19] ] );
cmp_deeply( merge_intervals( [ [2, 7], [3, 9], [10, 12], [15, 19], [18, 22] ] ),
            [ [2, 9], [10, 12], [15, 22] ] );
cmp_deeply( merge_intervals( [ [1, 2], [5, 6], [3, 4] ] ),
            [ [1, 2], [3, 4], [5, 6] ] );
cmp_deeply( merge_intervals( [ [1, 2], [5, 6], [2, 5] ] ),
            [ [1, 6] ] );
cmp_deeply( merge_intervals( [ [1, 1], [2, 2], [3, 3] ] ),
            [ [1, 1], [2, 2], [3, 3] ] );
cmp_deeply( merge_intervals( [ [1, 3], [4, 8], [5, 7] ] ),
            [ [1, 3], [4, 8] ] );
cmp_deeply( merge_intervals( [ [2, 3], [2, 5] ] ),
            [ [2, 5] ] );
cmp_deeply( merge_intervals( [ [2, 5], [2, 3] ] ),
            [ [2, 5] ] );

#
#
# METHODS

sub merge_intervals {
    my ($intervals) = @_;

    my $k;
    my $l;
    my $m;

    $intervals = _order_intervals($intervals);

    foreach my $interval (@$intervals) {
        my $i = $interval->[0];

        if (defined $l && defined $k) {
            if (($i <= $l) || ($k == $i)) {
                $k = $interval->[1];
                if ($m->[-1]->[1] < $k) {
                    $m->[-1]->[1] = $k;
                }
                next;
            }
        }

        my ($j, $_k) = _merge_intervals($interval->[1], $intervals);

        if ($j < $interval->[1]) {
            $j = $interval->[1];
        }

        push @$m, [$i, $j];

        $k = $_k;
        $l = $j;
    }

    return $m;
}

sub _order_intervals {
    my ($intervals) = @_;

    my @intervals = ();
    foreach my $i (@$intervals) {
        push @intervals, sprintf("%d-%d", $i->[0], $i->[1]);
    }

    # Borrowed
    # https://stackoverflow.com/questions/27089498/sorting-arrays-of-intervals-in-perl
    my @_sorted = sort {
        my ($a1, $a2) = $a =~ /\d+/g;
        my ($b1, $b2) = $b =~ /\d+/g;
        $a1 <=> $b1 || $a2 <=> $b2;
    } @intervals;

    my $sorted = [];
    foreach (@_sorted) {
        my ($a, $b) = split /\-/, $_, 2;
        push @$sorted, [ $a+0, $b+0 ];
    }

    return $sorted;
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

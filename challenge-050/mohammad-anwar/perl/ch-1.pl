#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
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
# Test case borrowed from E. Choroba contributions.
# https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-050/e-choroba/perl/ch-1.pl

cmp_deeply( merge_intervals([[1,2]]), [[1,2]]);
cmp_deeply( merge_intervals([[1,2],[3,4]]), [[1,2],[3,4]]);
cmp_deeply( merge_intervals([[3,4],[1,2]]), [[1,2],[3,4]]);

cmp_deeply( merge_intervals([[2,5],[1,2]]), [[1,5]]);
cmp_deeply( merge_intervals([[2,5],[1,3]]), [[1,5]]);
cmp_deeply( merge_intervals([[2,5],[1,5]]), [[1,5]]);
cmp_deeply( merge_intervals([[2,5],[1,6]]), [[1,6]]);
cmp_deeply( merge_intervals([[2,5],[2,3]]), [[2,5]]);
cmp_deeply( merge_intervals([[2,5],[2,5]]), [[2,5]]);
cmp_deeply( merge_intervals([[2,5],[2,6]]), [[2,6]]);
cmp_deeply( merge_intervals([[2,5],[3,4]]), [[2,5]]);
cmp_deeply( merge_intervals([[2,5],[3,5]]), [[2,5]]);
cmp_deeply( merge_intervals([[2,5],[3,6]]), [[2,6]]);
cmp_deeply( merge_intervals([[2,5],[5,6]]), [[2,6]]);

cmp_deeply( merge_intervals([[1,3],[5,7],[-1,0]]), [[-1,0],[1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[-1,1]]), [[-1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[-1,2]]), [[-1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[-1,3]]), [[-1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[-1,4]]), [[-1,4],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[-1,5]]), [[-1,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[-1,6]]), [[-1,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[-1,7]]), [[-1,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[-1,8]]), [[-1,8]]);

cmp_deeply( merge_intervals([[1,3],[5,7],[1,2]]), [[1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[1,3]]), [[1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[1,4]]), [[1,4],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[1,5]]), [[1,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[1,6]]), [[1,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[1,7]]), [[1,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[1,8]]), [[1,8]]);

cmp_deeply( merge_intervals([[1,3],[5,7],[2,2]]), [[1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[2,3]]), [[1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[2,4]]), [[1,4],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[2,5]]), [[1,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[2,6]]), [[1,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[2,7]]), [[1,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[2,8]]), [[1,8]]);

cmp_deeply( merge_intervals([[1,3],[5,7],[3,3]]), [[1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[3,4]]), [[1,4],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[3,5]]), [[1,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[3,6]]), [[1,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[3,7]]), [[1,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[3,8]]), [[1,8]]);

cmp_deeply( merge_intervals([[1,3],[5,7],[4,4]]), [[1,3],[4,4],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[4,5]]), [[1,3],[4,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[4,6]]), [[1,3],[4,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[4,7]]), [[1,3],[4,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[4,8]]), [[1,3],[4,8]]);

cmp_deeply( merge_intervals([[1,3],[5,7],[5,5]]), [[1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[5,6]]), [[1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[5,7]]), [[1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[5,8]]), [[1,3],[5,8]]);

cmp_deeply( merge_intervals([[1,3],[5,7],[6,6]]), [[1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[6,7]]), [[1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[6,8]]), [[1,3],[5,8]]);

cmp_deeply( merge_intervals([[1,3],[5,7],[7,7]]), [[1,3],[5,7]]);
cmp_deeply( merge_intervals([[1,3],[5,7],[7,8]]), [[1,3],[5,8]]);

cmp_deeply( merge_intervals([[1,3],[5,7],[8,8]]), [[1,3],[5,7],[8,8]]);

cmp_deeply( merge_intervals([[1,2],[5,6],[3,4]]), [[1,2],[3,4],[5,6]]);
cmp_deeply( merge_intervals([[1,2],[5,6],[2,5]]), [[1,6]]);
cmp_deeply( merge_intervals([[1,1],[2,2],[3,3]]), [[1,1],[2,2],[3,3]]);

cmp_deeply( merge_intervals([[0,6],[7,8],[12,19],[3,8]]), [[0,8],[12,19]]);
cmp_deeply( merge_intervals([[12,14],[15,19],[7,8],[1,12]]), [[1,14],[15,19]]);
cmp_deeply( merge_intervals([[12,17],[18,18],[9,9],[5,17]]), [[5,17],[18,18]]);

cmp_deeply( merge_intervals([[2,7],[3,9],[10,12],[15,19],[18,22]]), [[2,9],[10,12],[15,22]]);

done_testing();

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

# Ryan Thompson suggested version as in review blog.
# https://perlweeklychallenge.org/blog/review-challenge-050
sub _order_intervals {
    [ sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] } @{$_[0]} ]
}

# My unnecessary over complicated version.
sub __order_intervals {
    my ($intervals) = @_;

    my @intervals = ();
    foreach my $i (@$intervals) {
        push @intervals, sprintf("%d-%d", $i->[0], $i->[1]);
    }

    # Borrowed with input from E. Choroba
    # https://stackoverflow.com/questions/27089498/sorting-arrays-of-intervals-in-perl
    my @_sorted = sort {
        my ($a1, $a2) = $a =~ /-?\d+/g;
        my ($b1, $b2) = $b =~ /-?\d+/g;
        $a1 <=> $b1 || $a2 <=> $b2;
    } @intervals;

    my $sorted = [];
    foreach (@_sorted) {
        my ($a, $b) = split /(?<=\d)-(?=\d)/, $_, 2;
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

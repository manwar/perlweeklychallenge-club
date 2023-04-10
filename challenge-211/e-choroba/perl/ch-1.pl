#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub toeplitz_matrix($m) {
    my $x = 0;
    my $y = $#$m;
    while ($x <= $#{ $m->[0] }) {
        my ($u, $v) = ($x, $y);
        while (++$u <= $#{ $m->[0] } && ++$v <= $#$m) {
            return if $m->[$v][$u] != $m->[$y][$x];
        }
    } continue {
        if ($y) {
            --$y;
        } else {
            ++$x;
        }
    }
    return 1
}

use Test::More tests => 4;

ok toeplitz_matrix([ [4, 3, 2, 1],
                     [5, 4, 3, 2],
                     [6, 5, 4, 3],
                 ]), 'Example 1';

ok ! toeplitz_matrix([ [1, 2, 3],
                       [3, 2, 1],
                   ]), 'Example 2';

ok toeplitz_matrix([[1]]), '1x1';
ok toeplitz_matrix([[1,2,3,4,5,6,7],
                    [8,1,2,3,4,5,6],
                    [9,8,1,2,3,4,5],
                    [10,9,8,1,2,3,4],
                    [11,10,9,8,1,2,3],
                    [12,11,10,9,8,1,2],
                    [13,12,11,10,9,8,1],
                    [14,13,12,11,10,9,8],
                    [15,14,13,12,11,10,9],
                    [16,15,14,13,12,11,10],
                    [17,16,15,14,13,12,11],
                ]), 'Larger';

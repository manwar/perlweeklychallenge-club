#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ first max };

sub reduced_row_echelon($m) {
    my $previous_pos = -1;
    for my $row (@$m) {
        my $f = first { $row->[$_] } 0 .. $#$row;
        # Leading 1.
        return 0 if defined $f && $row->[$f] != 1;

        # We don't check the zeroes are at the bottom, because we pretend
        # they have 1s past the end of each row.
        $f //= 1 + max($previous_pos, $#$row);

        # Leading 1 farther right.
        return 0 if $f <= $previous_pos;

        $previous_pos = $f;

        # Single 1 in a column.
        return 0 if $f < $#$row && 1 < grep $_->[$f], @$m;
    }
    return 1
}

use Test::More tests => 7 + 1;

is reduced_row_echelon([
    [1,0,0,1],
    [0,1,0,2],
    [0,0,1,3]
]), 1, 'Example 0';

is reduced_row_echelon([
    [1, 1, 0],
    [0, 1, 0],
    [0, 0, 0]
]), 0, 'Example 1';

is reduced_row_echelon([
    [0, 1,-2, 0, 1],
    [0, 0, 0, 1, 3],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0]
]), 1, 'Example 2';

is reduced_row_echelon([
    [1, 0, 0, 4],
    [0, 1, 0, 7],
    [0, 0, 1,-1]
]), 1, 'Example 3';

is reduced_row_echelon([
    [0, 1,-2, 0, 1],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 1, 3],
    [0, 0, 0, 0, 0]
]), 0, 'Example 4';

is reduced_row_echelon([
    [0, 1, 0],
    [1, 0, 0],
    [0, 0, 0]
]), 0, 'Example 5';

is reduced_row_echelon([
    [4, 0, 0, 0],
    [0, 1, 0, 7],
    [0, 0, 1,-1]
]), 0, 'Example 6';

is reduced_row_echelon([
    [0, 0, 0],
    [0, 0, 0]
]), 1, 'All zeros';

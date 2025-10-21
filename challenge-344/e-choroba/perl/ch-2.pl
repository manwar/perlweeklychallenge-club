#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use constant { true => !!1, false => !!0 };

sub array_formation($source, $target) {
    return true if ! @$source && ! @$target;
    for my $i (0 .. $#$source) {
        my $start = $source->[$i];
        next if grep @$target >= @$start
             && $target->[$_] != $start->[$_], 0 .. $#$start;
        return true
            if @$start <= @$target
            && array_formation([@$source[grep $_ != $i, 0 .. $#$source]],
                               [@$target[$#$start + 1 .. $#$target]]);
    }
    return false
}

use Test2::V0;
plan(5 + 2);

is array_formation([[2,3], [1], [4]], [1, 2, 3, 4]), true, 'Example 1';
is array_formation([[1,3], [2,4]], [1, 2, 3, 4]), false, 'Example 2';
is array_formation([[9,1], [5,8], [2]], [5, 8, 2, 9, 1]), true, 'Example 3';
is array_formation([[1], [3]], [1, 2, 3]), false, 'Example 4';
is array_formation([[7,4,6]], [7, 4, 6]), true, 'Example 5';

is array_formation([[1,2,3],[4],[5,6],[1,2],[3,4,5]], [1,2,3,4,5,1,2,3,4,5,6]),
    true, 'Backtracking';
is array_formation([[1,2,3],[4],[5,6],[1,2],[3,4]], [1,2,3,4,5,6,1,2,3,4,5]),
    false, 'Backtracking to false';

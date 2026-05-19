#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub list_division($n, @list) {
    my $size = int(@list / $n);
    return -1 if $n > @list;

    my $rest = @list % $n;
    my @result;
    for my $part (1 .. $n) {
        push @result, [splice @list, 0, $size + ($part <= $rest)];
    }
    return @result
}

use Test2::V0;
plan(6 + 1);

is [list_division(2, 1, 2, 3, 4, 5)], [[1, 2, 3], [4, 5]], 'Example 1';
is [list_division(3, 1, 2, 3, 4, 5, 6)], [[1, 2], [3, 4], [5, 6]], 'Example 2';
is [list_division(2, 1, 2, 3)], [[1, 2], [3]], 'Example 3';
is [list_division(5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)],
    [[1, 2], [3, 4], [5, 6], [7, 8], [9, 10]], 'Example 4';
is [list_division(4, 1, 2, 3)], [-1], 'Example 5';
is [list_division(7, 72, 57, 89, 55, 36, 84, 10, 95, 99, 35)],
    [[72, 57], [89, 55], [36, 84], [10], [95], [99], [35]], 'Example 6';

is [list_division(1, 6, 7, 8)], [[6, 7, 8]], 'Single group';

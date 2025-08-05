#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub straight_line(@list) {
    my ($x, $y) = @{ $list[0] };
    my ($vx, $vy);
    for my $point (@list[1 .. $#list]) {
        next if $point->[0] == $x && $point->[1] == $y;

        my $nvx = $x - $point->[0];
        my $nvy = $y - $point->[1];
        if (defined $vx) {
            return if ($vx != 0 && $nvx != 0 && $vy / $vx != $nvy / $nvx)
                   || ($vx == 0 xor $nvx == 0);
        } else {
            ($vx, $vy) = ($nvx, $nvy);
        }
    }
    return 1
}

use Test2::V0;
use constant { true => 1, false => 0 };
plan(5 + 13);

is straight_line([2, 1], [2, 3], [2, 5]), bool(true), 'Example 1';
is straight_line([1, 4], [3, 4], [10, 4]), bool(true), 'Example 2';
is straight_line([0, 0], [1, 1], [2, 3]), bool(false), 'Example 3';
is straight_line([1, 1], [1, 1], [1, 1]), bool(true), 'Example 4';
is straight_line([1000000, 1000000], [2000000, 2000000], [3000000, 3000000]),
    bool(true), 'Example 5';

is straight_line([0, 0]), bool(true), 'single point';
is straight_line([0, 1], [1, 0]), bool(true), 'two points';
is straight_line([1, 4], [2, 6], [3, 8], [4, 10]), bool(true), 'Four points';
is straight_line([0, 1], [2, 3], [3, 4], [-5, -4]), bool(true),
    'Negative values';
is straight_line([1, 2], [3, 7], [3, 7]), bool(true), 'B=C';
is straight_line([1, 2], [3, 7], [1, 2]), bool(true), 'A=C';
is straight_line([1, 2], [1, 2], [3, 7]), bool(true), 'A=B';
is straight_line([2, 1], [2, 3], [3, 4]), bool(false), 'Not y';
is straight_line([2, 1], [3, 3], [2, 4]), bool(false), 'Not y';
is straight_line([3, 1], [2, 3], [2, 4]), bool(false), 'Not y';
is straight_line([3, 2], [1, 3], [1, 4]), bool(false), 'Not x';
is straight_line([1, 2], [3, 3], [1, 4]), bool(false), 'Not x';
is straight_line([1, 2], [1, 3], [3, 4]), bool(false), 'Not x';

#!/usr/bin/perl
use warnings;
use strict;

sub left_rotation {
    my ($list, $rotations) = @_;
    return [ map {
        [ @$list[$_ .. $#$list], @$list[0 .. $_ - 1] ]
    } @$rotations ]
}

use Test::More tests => 2;

is_deeply left_rotation([10, 20, 30, 40, 50], [3, 4]),
    [ [40, 50, 10, 20, 30],
      [50, 10, 20, 30, 40] ];

is_deeply left_rotation([ 7, 4, 2, 6, 3 ], [1, 3, 4]),
    [ [ 4, 2, 6, 3, 7 ],
      [ 6, 3, 7, 4, 2 ],
      [ 3, 7, 4, 2, 6 ] ];


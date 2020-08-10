#! /usr/bin/perl
use warnings;
use strict;

use List::Util qw{ min };

sub min_sliding_window {
    my ($arr, $size) = @_;
    [ map min(@$arr[$_ .. $_ + $size - 1]),
          0 .. $#$arr - $size + 1 ]
}

use Test::More tests => 1;
is_deeply
    min_sliding_window([1, 5, 0, 2, 9, 3, 7, 6, 4, 8], 3),
    [0, 0, 0, 2, 3, 3, 4, 4];


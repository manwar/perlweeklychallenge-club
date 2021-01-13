#!/usr/bin/perl
use warnings;
use strict;

sub combinations {
    my ($max, $size) = @_;
    if ($size == 1) {
        return map [$_], 1 .. $max
    } else {
        return map {
            my @c = @$_;
            map [@c, $_], $c[-1] + 1 .. $max
        } combinations($max, $size - 1)
    }
}

use Test::More tests => 1;
is_deeply [combinations(5, 2)],
    [ [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5] ];

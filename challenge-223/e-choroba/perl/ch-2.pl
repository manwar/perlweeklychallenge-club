#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max };

sub box_coins(@box) {
    return 0 unless @box;

    return $box[0] if 1 == @box;

    return max(map {
        my $i = $_;
        my $prev = $i          ? $box[ $i - 1 ] : 1;
        my $next = $i != $#box ? $box[ $i + 1 ] : 1;

        no warnings 'recursion';
        $prev * $next * $box[$i] + box_coins(@box[ grep $i != $_, 0 .. $#box ])
    } 0 .. $#box)
}

# 3.8s -> 0.05s
use Memoize;
memoize 'box_coins';
box_coins(map int rand 10, 1 .. 10);

use Test::More tests => 2;

is box_coins(3, 1, 5, 8), 167, 'Example 1';
is box_coins(1, 5), 10, 'Example 2';

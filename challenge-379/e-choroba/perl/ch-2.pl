#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };
use Math::BaseConvert qw{ cnv };

sub armstrong_number($base, $limit) {
    return grep is_armstrong($base, $_), 0 .. $limit
}

my %base2ten;  # Caching speeds up the whole test 2 times.
sub is_armstrong($base, $n) {
    $base2ten{$base} //= {map +(cnv($_, 10, $base) => $_), 0 .. $base - 1};
    my $in_base = cnv($n, 10, $base);
    my $l = length $in_base;
    my $s = sum(map $base2ten{$base}{$_} ** $l, split //, $in_base);
    return $s == $n
}

use Test2::V0;
plan(3);

is [armstrong_number(10, 1000)],
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407], 'Example 1';

is [armstrong_number(7, 1000)],
    [0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250], 'Example 2';

is [armstrong_number(16, 1000)],
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584,
     645],
    'Example 3';

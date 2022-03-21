#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::Util qw{ sum product };

sub pythagorean_means (@n) {
    my %result = (
        AM => sum(@n) / @n,
        GM => abs(product(@n)) ** (1 / @n),
        HM => @n / sum(map 1 / $_, @n) );
    $_ = sprintf '%.1f', $_ for values %result;
    return \%result
}

use Test2::V0;
use Test2::Tools::Compare qw{ number };
plan 3;

is pythagorean_means(1, 3, 5, 6, 9),
    {AM => number(4.8), GM => number(3.8), HM => number(2.8)},
    'Example 1';
is pythagorean_means(2, 4, 6, 8, 10),
    {AM => number(6.0), GM => number(5.2), HM => number(4.4)},
    'Example 2';
is pythagorean_means(1, 2, 3, 4, 5),
    {AM => number(3.0), GM => number(2.6), HM => number(2.2)},
    'Example 3';

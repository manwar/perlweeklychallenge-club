#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

sub special_numbers(@ints) {
    my @s = @ints[grep 0 == @ints % ($_ + 1), 0 .. $#ints];
    return sum(map $_ * $_, @s)
}

use Test::More tests => 2;

is special_numbers(1, 2, 3, 4), 21, 'Example 1';
is special_numbers(2, 7, 1, 19, 18, 3), 63, 'Example 2';

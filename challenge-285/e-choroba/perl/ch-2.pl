#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Memoize;
memoize qw{ making_change_rec };

my @coins = (1, 5, 10, 25, 50);

sub making_change($amount) {
    making_change_rec($amount, 1);
}

sub making_change_rec($amount, $min) {
    return 1 if 0 == $amount;
    my $ways = 0;
    {   no warnings 'recursion';
        $ways += making_change_rec($amount - $_, $_)
            for grep $_ >= $min && $amount >= $_, @coins;
    }
    return $ways
}

use Test::More tests => 3 + 1;

is making_change(9), 2, 'Example 1';
is making_change(15), 6, 'Example 2';
is making_change(100), 292, 'Example 3';

# Memoize needed.
is making_change(1000), 801451, 'Large';

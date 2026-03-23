#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub count_prefixes($str, @array) {
    return scalar grep 0 == index($str, $_), @array
}

use Test::More tests => 5;

is count_prefixes('apple', 'a', 'ap', 'app', 'apple', 'banana'), 4, 'Example 1';
is count_prefixes('bird', 'cat', 'dog', 'fish'), 0, 'Example 2';
is count_prefixes('hello', 'hello', 'he', 'hell', 'heaven', 'he'), 4,
    'Example 3';
is count_prefixes('coding', '', 'code', 'coding', 'cod'), 3, 'Example 4';
is count_prefixes('program', 'p', 'pr', 'pro', 'prog', 'progr', 'progra',
                  'program'),
    7, 'Example 5';

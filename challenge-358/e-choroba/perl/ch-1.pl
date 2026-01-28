#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max };

sub max_str_value(@strings) {
    return max(map /[a-z]/ ? length : 0 + $_, @strings)
}

use Test::More tests => 5;

is max_str_value('123', '45', '6'), 123, 'Example 1';
is max_str_value('abc', 'de', 'fghi'), 4, 'Example 2';
is max_str_value('0012', '99', 'a1b2c'), 99, 'Example 3';
is max_str_value('x', '10', 'xyz', '007'), 10, 'Example 4';
is max_str_value('hello123', '2026', 'perl'), 2026, 'Example 5';

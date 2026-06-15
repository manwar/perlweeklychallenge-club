#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ uniq };

sub second_largest_digit($str) {
    (sort +uniq($str =~ /([0-9])/g))[-2] // -1
}

use Test::More tests => 5;

is second_largest_digit('aaaaa77777'), -1, 'Example 1';
is second_largest_digit('abcde'), -1, 'Example 2';
is second_largest_digit('9zero8eight7seven9'), 8, 'Example 3';
is second_largest_digit('xyz9876543210'), 8, 'Example 4';
is second_largest_digit('4abc4def2ghi8jkl2'), 4, 'Example 5';

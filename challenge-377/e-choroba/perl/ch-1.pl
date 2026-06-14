#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub reverse_existence($str) {
    $str =~ /(?=(.)(.))(?=.*\2\1)/
}

use Test2::V0;
plan(5);

use constant {true => bool(1), false => bool(0)};

is reverse_existence('abcba'), true, 'Example 1';
is reverse_existence('racecar'), true, 'Example 2';
is reverse_existence('abcd'), false, 'Example 3';
is reverse_existence('banana'), true, 'Example 4';
is reverse_existence('hello'), true, 'Example 5';

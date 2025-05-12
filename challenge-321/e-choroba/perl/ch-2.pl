#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub backspace_compare($str1, $str2) {
    for ($str1, $str2) {
        1 while s/[^#]#//;
    }
    return $str1 eq $str2
}

use Test2::V0;
plan(3);

is backspace_compare('ab#c', 'ad#c'), bool(1), 'Example 1';
is backspace_compare('ab##', 'a#b#'), bool(1), 'Example 2';
is backspace_compare('a#b', 'c'), bool(0), 'Example 3';

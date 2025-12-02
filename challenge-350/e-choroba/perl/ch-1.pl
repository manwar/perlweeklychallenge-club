#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub good_substrings($str) {
    scalar grep ! /(.).*\1/, $str =~ /(?=(...))/g
}

use Test::More tests => 5;

is good_substrings('abcaefg'), 5, 'Example 1';
is good_substrings('xyzzabc'), 3, 'Example 2';
is good_substrings('aababc'), 1, 'Example 3';
is good_substrings('qwerty'), 4, 'Example 4';
is good_substrings('zzzaaa'), 0, 'Example 5';

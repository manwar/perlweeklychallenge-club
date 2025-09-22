#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub duplicate_removals($str) {
    1 while $str =~ s/(.)\1//g;
    return $str
}

use Test::More tests => 5 + 2;

is duplicate_removals('abbaca'), 'ca', 'Example 1';
is duplicate_removals('azxxzy'), 'ay', 'Example 2';
is duplicate_removals('aaaaaaaa'), "", 'Example 3';
is duplicate_removals('aabccba'), 'a', 'Example 4';
is duplicate_removals('abcddcba'), "", 'Example 5';

is duplicate_removals('aaa'), 'a', 'Odd length';
is duplicate_removals('aabccdeedffbgg'), "", 'Many steps';

#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub decode_string($str) {
    1 while $str =~ s/([0-9]+) \[ ( [^\[\]]+ ) \] /$2 x $1/gex;
    return $str
}

use Test::More tests => 5;

is decode_string('2[3[a]]'), 'aaaaaa', 'Example 1';
is decode_string('10[a]'), 'aaaaaaaaaa', 'Example 2';
is decode_string('a2[b]c3[d]e'), 'abbcddde', 'Example 3';
is decode_string('2[a2[b]c]'), 'abbcabbc', 'Example 4';
is decode_string('1[a]2[b3[c]]'), 'abcccbccc', 'Example 5';

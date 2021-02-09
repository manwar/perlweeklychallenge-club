#!/usr/bin/perl
use warnings;
use strict;

sub pattern_match {
    my ($string, $pattern) = @_;
    $pattern = quotemeta $pattern;
    s/\\\?/./g, s/\\\*/.*/g for $pattern;
    return $string =~ /^$pattern$/ ? 1 : 0
}

use Test::More tests => 8;

is pattern_match('abcde', 'a*e'),   1, 'Example 1';
is pattern_match('abcde', 'a*d'),   0, 'Example 2';
is pattern_match('abcde', '?b*d'),  0, 'Example 3';
is pattern_match('abcde', 'a*c?e'), 1, 'Example 4';

is pattern_match('abcde', 'a*'),  1, 'Trailing star';
is pattern_match('abcde', '*de'), 1, 'Leading star';
is pattern_match('abcde', 'a*c*e'), 1, 'Two stars';
is pattern_match('(a!)b{c}$1d', '(?!)b{?}$1*'), 1, 'No injection';

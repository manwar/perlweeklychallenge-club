#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my $bad = join '|', map "$_\u$_|\u$_$_", 'a' .. 'z';

sub good_string($str) {
    1 while $str =~ s/$bad//;
    return $str
}

use Test::More tests => 3;

is good_string('WeEeekly'), 'Weekly', 'Example 1';
is good_string('abBAdD'), '', 'Example 2';
is good_string('abc'), 'abc', 'Example 3';

#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub reverse_prefix($str, $char) {
    my $i = 1 + index $str, $char;
    return $str if 1 >= $i;

    substr $str, 0, $i, reverse substr $str, 0, $i;
    return $str
}

use Test::More tests => 5;

is reverse_prefix('programming', 'g'), 'gorpramming', 'Example 1';
is reverse_prefix('hello', 'h'), 'hello', 'Example 2';
is reverse_prefix('abcdefghij', 'h'), 'hgfedcbaij', 'Example 3';
is reverse_prefix('reverse', 's'), 'srevere', 'Example 4';
is reverse_prefix('perl', 'r'), 'repl', 'Example 5';

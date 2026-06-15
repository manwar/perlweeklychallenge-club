#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );
use experimental qw( signatures );

sub sum_of_words($str1, $str2, $str3) {
    my @n = map tr/a-j/0-9/r || 0, $str1, $str2, $str3;
    return $n[0] + $n[1] == $n[2]
}

use Test2::V0;
plan(6 + 5);

use if ($] >= 5.036), builtin => qw( true false );
use if ($] <  5.036), constant => {true => 1, false => 0};

is sum_of_words('acb', 'cba', 'cdb'), bool(true), 'Example 1';
is sum_of_words('aab', 'aac', 'ad'), bool(true), 'Example 2';
is sum_of_words('bc', 'je', 'jg'), bool(false), 'Example 3';
is sum_of_words('a', 'aaaa', 'aa'), bool(true), 'Example 4';
is sum_of_words('c', 'd', 'h'), bool(false), 'Example 5';
is sum_of_words('gfi', 'hbf', 'bdhd'), bool(true), 'Example 6';

is sum_of_words("", "", ""), bool(true), 'Empty x 3';
is sum_of_words("a", "", ""), bool(true), '0 Empty x 2';
is sum_of_words("a", "", "a"), bool(true), '0 Empty 0';
is sum_of_words("", "a", "a"), bool(true), 'Empty 0 0';
is sum_of_words("a", "a", "a"), bool(true), '0 x 3';

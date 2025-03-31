#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub find_words($char, @list) {
    [grep -1 != index($list[$_], $char), 0 .. $#list]
}

use Test2::V0;
plan(3 + 1);

is find_words('e', 'the', 'weekly', 'challenge'), [0, 1, 2], 'Example 1';
is find_words('p', 'perl', 'raku', 'python'), [0, 2], 'Example 2';
is find_words('b', 'abc', 'def', 'bbb', 'bcd'), [0, 2, 3], 'Example 3';

is find_words('x', 'none', 'of', 'the', 'words'), [], 'None';

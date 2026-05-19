#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub equal_list($arr1, $arr2) {
    return join("", @$arr1) eq join("", @$arr2)
}

use Test2::V0;
plan(5);
use constant {true  => bool(1),
              false => bool(0)};

is equal_list(['a', 'bc'], ['ab', 'c']), true, 'Example 1';
is equal_list(['a', 'b', 'c'], ['a', 'bc']), true, 'Example 2';
is equal_list(['a', 'bc'], ['a', 'c', 'b']), false, 'Example 3';
is equal_list(['ab', 'c', ''], ['', 'a', 'bc']), true, 'Example 4';
is equal_list(['p', 'e', 'r', 'l'], ['perl']), true, 'Example 5';

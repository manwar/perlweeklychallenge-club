#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( bitwise signatures );

sub merge_strings($str1, $str2) {
    my $s = "";
    for my $i (0 .. length($str1 |. $str2)) {
        no warnings 'substr';
        $s .= (substr($_, $i, 1) // "") for $str1, $str2;
    }
    return $s
}

use Test::More tests => 3 + 1;

is merge_strings('abcd', '1234'), 'a1b2c3d4', 'Example 1';
is merge_strings('abc', '12345'), 'a1b2c345', 'Example 2';
is merge_strings('abcde', '123'), 'a1b2c3de', 'Example 3';
is merge_strings("", ""), "", 'Empty';

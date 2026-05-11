#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub largest_substring($str) {
    my $l = 0;
    $l < length $2 and $l = length $2 while $str =~ /(.)(?=(.*)\1)/g;
    return $l
}

use Test::More tests => 5;

is largest_substring('aaaaa'), 3, 'Example 1';
is largest_substring('abcdeba'), 5, 'Example 2';
is largest_substring('abbc'), 0, 'Example 3';
is largest_substring('abcaacbc'), 4, 'Example 4';
is largest_substring('laptop'), 2, 'Example 5';

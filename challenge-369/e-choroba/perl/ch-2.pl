#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub group_division($str, $size, $filler) {
    my @g = $str =~ /(.{1,$size})/g;
    @g = ("") unless @g;
    $g[-1] .= $filler x ($size - length($g[-1]));
    return @g
}

use Test2::V0;
plan(5 + 1);

is [group_division('RakuPerl', 4, '*')], ['Raku', 'Perl'], 'Example 1';
is [group_division('Python', 5, '0')], ['Pytho', 'n0000'], 'Example 2';
is [group_division('12345', 3, 'x')], ['123', '45x'], 'Example 3';
is [group_division('HelloWorld', 3, '_')], ['Hel', 'loW', 'orl', 'd__'],
    'Example 4';
is [group_division('AI', 5, '!')], ['AI!!!'], 'Example 5';

is [group_division("", 2, 'e')], ['ee'], 'Empty string';

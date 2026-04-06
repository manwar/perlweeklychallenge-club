#!/usr/bin/env perl

# You are given a binary string that has at least one ‘1’.

# Write a script to rearrange the bits in such a way that the resulting
# binary number is the maximum odd binary number and return the resulting
# binary string. The resulting string can have leading zeros.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub max_odd_binary {
    my $str    = shift;
    my $result = 0;
    printf qq{ Input: \$str = "%s"\n }, $str;

    my @bits;
    $bits[$_]++ for split "", $str;
    $result = '1' x ( $bits[1] - 1 ) . '0' x $bits[0] . '1';

    printf qq{Output: %s\n}, $result;
    return $result;
}

my @examples = (
                 { in => "1011",   out => "1101",   name => 'example 1' },
                 { in => "100",    out => "001",    name => 'example 2' },
                 { in => "111000", out => "110001", name => 'example 3' },
                 { in => "0101",   out => "1001",   name => 'example 4' },
                 { in => "1111",   out => "1111",   name => 'example 5' },
               );

is( max_odd_binary( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;

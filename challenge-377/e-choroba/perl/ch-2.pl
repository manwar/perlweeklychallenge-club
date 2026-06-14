#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub prefix_suffix(@array) {
    my %found;
    for my $i (0 .. $#array) {
        my $str1 = $array[$i];
        for my $j (0 .. $#array) {
            next if $i == $j;

            my $str2 = $array[$j];
            next if 0 != index($str2, $str1)
                 || abs(length($str2) - length($str1)) != rindex $str2, $str1;

            # Example 4 shows we don't count the same tuple twice.
            undef $found{ join ':', sort { $a <=> $b } $i, $j };
        }
    }
    return scalar keys %found
}

use Test::More tests => 6;

is prefix_suffix('a', 'aba', 'ababa', 'aa'), 4, 'Example 1';
is prefix_suffix('pa', 'papa', 'ma', 'mama'), 2, 'Example 2';
is prefix_suffix('abao', 'ab'), 0, 'Example 3';
is prefix_suffix('abab', 'abab'), 1, 'Example 4';
is prefix_suffix('ab', 'abab', 'ababab'), 3, 'Example 5';
is prefix_suffix('abc', 'def', 'ghij'), 0, 'Example 6';

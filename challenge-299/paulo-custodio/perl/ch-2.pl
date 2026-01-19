#!/usr/bin/env perl

# Challenge 299
#
# Task 2: Word Search
# Submitted by: Mohammad Sajid Anwar
# You are given a grid of characters and a string.
#
# Write a script to determine whether the given string can be found in the given grid of characters. You may start anywhere and take any orthogonal path, but may not reuse a grid cell.
#
# Example 1
# Input: @chars = (['A', 'B', 'D', 'E'],
#                  ['C', 'B', 'C', 'A'],
#                  ['B', 'A', 'A', 'D'],
#                  ['D', 'B', 'B', 'C'])
#       $str = 'BDCA'
# Output: true
# Example 2
# Input: @chars = (['A', 'A', 'B', 'B'],
#                  ['C', 'C', 'B', 'A'],
#                  ['C', 'A', 'A', 'A'],
#                  ['B', 'B', 'B', 'B'])
#       $str = 'ABAC'
# Output: false
# Example 3
# Input: @chars = (['B', 'A', 'B', 'A'],
#                  ['C', 'C', 'C', 'C'],
#                  ['A', 'B', 'A', 'B'],
#                  ['B', 'B', 'A', 'A'])
#       $str = 'CCCAA'
# Output: true

use Modern::Perl;

my @chars;
while (<>) {
    last if /^\s*$/;
    my @r = split ' ', $_;
    push @chars, \@r;
}
chomp(my $str = scalar(<>));

say word_found($str, @chars) ? "true" : "false";

sub word_found {
    my($str, @chars) = @_;
    return 1 if $str eq '';

    for my $r (0 .. $#chars) {
        for my $c (0 .. $#{$chars[0]}) {
            return 1 if find_snake($r, $c, $str, @chars);
        }
    }

    # not found
    return 0;
}

sub find_snake {
    my($r, $c, $str, @chars) = @_;
    return 1 if $str eq '';
    return 0 if $chars[$r][$c] ne substr($str,0,1);

    $chars[$r][$c] = "#";
    $str = substr($str,1);

    # up
    if ($r > 0) {
        return 1 if find_snake($r-1, $c, $str, @chars);
    }
    # down
    if ($r < $#chars) {
        return 1 if find_snake($r+1, $c, $str, @chars);
    }
    # left
    if ($c > 0) {
        return 1 if find_snake($r, $c-1, $str, @chars);
    }
    # right
    if ($c < $#{$chars[0]}) {
        return 1 if find_snake($r, $c+1, $str, @chars);
    }

    # not found
    return 0;
}

#!/usr/bin/env perl
# Week 74 Task 2
# FNR Character
#
# You are given a string $S.
#
# Write a script to print the series of first non-repeating character
# (left -> right) for the given string. Print # if none found.
# Example 1
# Input: $S = ‘ababc’
# Output: ‘abb#c’
# Pass 1: “a”, the FNR character is ‘a’
# Pass 2: “ab”, the FNR character is ‘b’
# Pass 3: “aba”, the FNR character is ‘b’
# Pass 4: “abab”, no FNR found, hence ‘#’
# Pass 5: “ababc” the FNR character is ‘c’
#
# Example 2
# Input: $S = ‘xyzzyx’
# Output: ‘xyzyx#’
# Pass 1: “x”, the FNR character is “x”
# Pass 2: “xy”, the FNR character is “y”
# Pass 3: “xyz”, the FNR character is “z”
# Pass 4: “xyzz”, the FNR character is “y”
# Pass 5: “xyzzy”, the FNR character is “x”
# Pass 6: “xyzzyx”, no FNR found, hence ‘#’

use strict;
use warnings;
use feature qw/ say /;
use List::MoreUtils qw/ first_index /;
use Test::More;

my $string1_test = 'ababc';
my $string2_test = 'xyzzyx';
ok( first_non_repeating_characters($string1_test) eq 'abb#c',
    "test \'$string1_test\'" );
ok( first_non_repeating_characters($string2_test) eq 'xyzyx#',
    "test \'$string2_test\'" );
done_testing();

say first_non_repeating_characters($string1_test);
say first_non_repeating_characters($string2_test);

sub first_non_repeating_characters {
    my $string = shift;
    my @non_repeating;
    my @repeating;
    my $result;
    for my $char ( split //, $string ) {
        my $in_repeating     = grep { $_ eq $char } @repeating;
        my $in_non_repeating = grep { $_ eq $char } @non_repeating;
        if ($in_non_repeating) {
            my $index = first_index { $_ eq $char } @non_repeating;
            splice @non_repeating, $index, 1;
            push @repeating, $char;
        }
        elsif ( !$in_repeating && !$in_non_repeating ) {
            push @non_repeating, $char;
        }
        scalar @non_repeating > 0
          ? ( $result .= $non_repeating[-1] )
          : ( $result .= qw/ # / );
    }
    return $result;
}


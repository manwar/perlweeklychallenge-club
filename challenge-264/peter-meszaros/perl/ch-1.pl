#!/usr/bin/env perl
#
# You are given a string, $str, made up of only alphabetic characters
# [a..zA..Z].
# 
# Write a script to return the greatest english letter in the given string.
# 
#     A letter is greatest if it occurs as lower and upper case. Also letter
#     ‘b’ is greater than ‘a’ if ‘b’ appears after ‘a’ in the English alphabet.
# 
# Example 1
# 
# Input: $str = 'PeRlwEeKLy'
# Output: L
# 
# There are two letters E and L that appears as lower and upper.
# The letter L appears after E, so the L is the greatest english letter.
# 
# Example 2
# 
# Input: $str = 'ChaLlenge'
# Output: L
# Example 3
# 
# Input: $str = 'The'
# Output: ''
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ['PeRlwEeKLy', 'L', 'Example 1'],
    ['ChaLlenge',  'L', 'Example 2'],
    ['The',        '',  'Example 3'],
];

sub greatest_english_letter
{
    my $w = shift;

    my %h;
    for my $l (split(//, $w)) {
        my $ul = uc $l; 
        $h{$ul} |= (($l eq $ul) ? 1 : 2);
    }

    return (sort grep {$h{$_} == 3} keys %h)[-1] // '';
}

for (@$cases) {
    is(greatest_english_letter($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

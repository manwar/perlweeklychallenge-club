#!/usr/bin/env perl

# Task 1: Jumping Letters
# Submitted by: Mohammad S Anwar
#
# You are given a word having alphabetic characters only, and a list of positive integers of the same length
#
# Write a script to print the new word generated after jumping forward each letter in the given word by the integer in the list. The given list would have exactly the number as the total alphabets in the given word.
#
# Example 1
# Input: $word = 'Perl' and @jump = (2,22,19,9)
# Output: Raku
# 'P' jumps 2 place forward and becomes 'R'.
# 'e' jumps 22 place forward and becomes 'a'. (jump is cyclic i.e. after 'z' you go back to 'a')
# 'r' jumps 19 place forward and becomes 'k'.
# 'l' jumps 9 place forward and becomes 'u'.

# Example 2
# Input: $word = 'Raku' and @jump = (24,4,7,17)
# Output: 'Perl'

use strict;
use warnings;
use feature qw/say/;

sub tr_letter {
    my $ord = ord shift;
    return ($ord >= 97)
        ? chr ( ( $ord - 97 + shift ) % 26 + 97 )
        : chr ( ( $ord - 65 + shift ) % 26 + 65 );
}

sub tr_word {
    my $word = shift;
    my $jump = shift;
    return join '',
        map { tr_letter [split '', $word]->[$_], $jump->[$_] }
            0..(length $word)-1;
}

my $word = 'Perl';
my @jump = (2,22,19,9);

say tr_word($word, \@jump);

$word = 'Raku';
@jump = (24,4,7,17);
say tr_word($word, \@jump);

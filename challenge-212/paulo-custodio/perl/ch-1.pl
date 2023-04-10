#!/usr/bin/perl

# Challenge 212
#
# Task 1: Jumping Letters
# Submitted by: Mohammad S Anwar
#
# You are given a word having alphabetic characters only, and a list of positive
# integers of the same length
#
# Write a script to print the new word generated after jumping forward each
# letter in the given word by the integer in the list. The given list would have
# exactly the number as the total alphabets in the given word.
#
# Example 1
#
# Input: $word = 'Perl' and @jump = (2,22,19,9)
# Output: Raku
#
# 'P' jumps 2 place forward and becomes 'R'.
# 'e' jumps 22 place forward and becomes 'a'. (jump is cyclic i.e. after 'z' you go back to 'a')
# 'r' jumps 19 place forward and becomes 'k'.
# 'l' jumps 9 place forward and becomes 'u'.
#
# Example 2
#
# Input: $word = 'Raku' and @jump = (24,4,7,17)
# Output: 'Perl'

use Modern::Perl;

sub encode {
    my($word, @jumps) = @_;
    my @word = split //, $word;
    for my $i (0..$#word) {
        if ($word[$i] =~ /[a-z]/) {
            $word[$i] = chr(((ord($word[$i])-ord('a') + $jumps[$i]) % 26) + ord('a'));
        }
        elsif ($word[$i] =~ /[A-Z]/) {
            $word[$i] = chr(((ord($word[$i])-ord('A') + $jumps[$i]) % 26) + ord('A'));
        }
    }
    return join "", @word;
}

@ARGV or die "usage: ch-1.pl word jumps...\n";
say encode(@ARGV);

#!/usr/bin/env perl

# Challenge 346
#
# Task 1: Longest Parenthesis
# Submitted by: Mohammad Sajid Anwar
# You are given a string containing only ( and ).
#
# Write a script to find the length of the longest valid parenthesis.
#
#
# Example 1
# Input: $str = '(()())'
# Output: 6
#
# Valid Parenthesis: '(()())'
#
# Example 2
# Input: $str = ')()())'
# Output: 4
#
# Valid Parenthesis: '()()' at positions 1-4.
#
# Example 3
# Input: $str = '((()))()(((()'
# Output: 8
#
# Valid Parenthesis: '((()))()' at positions 0-7.
#
# Example 4
# Input: $str = '))))((()('
# Output: 2
#
# Valid Parenthesis: '()' at positions 6-7.
#
# Example 5
# Input: $str = '()(()'
# Output: 2
#
# Valid Parenthesis: '()' at positions 0-1 and 3-4.

use Modern::Perl;
@ARGV==1 or die "usage: $0 '())()()'\n";
say longest_sequence($ARGV[0]);

sub longest_sequence {
    my($str) = @_;
    my @in = split //, $str;
    my $longest = 0;
    for my $i (0 .. $#in) {
        my $len = sequence(@in[$i .. $#in]);
        $longest = $len if $len > $longest;
    }
    return $longest;
}

sub sequence {
    my(@in) = @_;
    my $nest = 0;
    my $last_ok = 0;
    for my $i (0 .. $#in) {
        if ($in[$i] eq '(') {
            $nest++;
        }
        elsif ($in[$i] eq ')') {
            if ($nest == 0) {
                return $i;
            }
            $nest--;
        }
        else {
            die "invalid character ", $in[$i];
        }
        $last_ok = $i+1 if $nest == 0;
    }
    return $last_ok;
}

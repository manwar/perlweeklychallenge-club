#!/usr/bin/env perl

# Challenge 348
#
# Task 1: String Alike
# Submitted by: Mohammad Sajid Anwar
# You are given a string of even length.
#
# Write a script to find out whether the given string can be split into two halves of equal lengths, each with the same non-zero number of vowels.
#
#
# Example 1
# Input: $str = "textbook"
# Output: false
#
# 1st half: "text" (1 vowel)
# 2nd half: "book" (2 vowels)
#
# Example 2
# Input: $str = "book"
# Output: true
#
# 1st half: "bo" (1 vowel)
# 2nd half: "ok" (1 vowel)
#
# Example 3
# Input: $str = "AbCdEfGh"
# Output: true
#
# 1st half: "AbCd" (1 vowel)
# 2nd half: "EfGh" (1 vowel)
#
# Example 4
# Input: $str = "rhythmmyth"
# Output: false
#
# 1st half: "rhyth" (0 vowel)
# 2nd half: "mmyth" (0 vowel)
#
# Example 5
# Input: $str = "UmpireeAudio"
# Output: false
#
# 1st half: "Umpire" (3 vowels)
# 2nd half: "eAudio" (5 vowels)

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";
say strings_alike($ARGV[0]) ? 'true' : 'false';

sub strings_alike {
    my($str) = @_;
    my $mid = int(length($str) / 2);
    my $s1 = substr($str, 0, $mid);
    my $s2 = substr($str, $mid);
    return if length($s1) != length($s2);
    my $n1 = num_vowels($s1);
    my $n2 = num_vowels($s2);
    return $n1 > 0 && $n1 == $n2;
}

sub num_vowels {
    my($str) = @_;
    return $str =~ tr/aeiouAEIOU/aeiouAEIOU/;
}

#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-348/#TASK1
#
# Task 1: String Alike
# ====================
#
# You are given a string of even length.
#
# Write a script to find out whether the given string can be split into two
# halves of equal lengths, each with the same non-zero number of vowels.
#
## Example 1
##
## Input: $str = "textbook"
## Output: false
##
## 1st half: "text" (1 vowel)
## 2nd half: "book" (2 vowels)
#
#
## Example 2
##
## Input: $str = "book"
## Output: true
##
## 1st half: "bo" (1 vowel)
## 2nd half: "ok" (1 vowel)
#
#
## Example 3
##
## Input: $str = "AbCdEfGh"
## Output: true
##
## 1st half: "AbCd" (1 vowel)
## 2nd half: "EfGh" (1 vowel)
#
#
## Example 4
##
## Input: $str = "rhythmmyth"
## Output: false
##
## 1st half: "rhyth" (0 vowel)
## 2nd half: "mmyth" (0 vowel)
#
#
## Example 5
##
## Input: $str = "UmpireeAudio"
## Output: false
##
## 1st half: "Umpire" (3 vowels)
## 2nd half: "eAudio" (5 vowels)
#
############################################################
##
## discussion
##
############################################################
#
# We turn the string into an array of characters. Then we walk from
# both the left and the right side at the same time, counting the
# vowels as we go along. In the end we check if both halves of the
# string had the same amount of vowels, and if so whether that number
# is bigger than 1.

use v5.36;

string_alike("textbook");
string_alike("book");
string_alike("AbCdEfGh");
string_alike("rhythmmyth");
string_alike("UmpireeAudio");

sub string_alike($str) {
    say "Input: \"$str\"";
    my @chars = split //, $str;
    my $vl = 0;
    my $vr = 0;
    while(@chars) {
        my $l = shift @chars;
        my $r = pop @chars;
        $vl++ if is_vowel($l);
        $vr++ if is_vowel($r);
    }
    if($vl == $vr) {
        if($vl > 0) {
            return say "Output: true";
        }
    }
    say "Output: false";
}

sub is_vowel($c) {
    $c = lc($c);
    return 1 if $c eq "a" or $c eq "e" or $c eq "i" or $c eq "o" or $c eq "u";
    return 0;
}

#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-374/#TASK1
#
# Task 1: Count Vowel
# ===================
#
# You are given a string.
#
# Write a script to return all possible vowel substrings in the given string. A
# vowel substring is a substring that only consists of vowels and has all five
# vowels present in it.
#
## Example 1
##
## Input: $str = "aeiou"
## Output: ("aeiou")
#
## Example 2
##
## Input: $str = "aaeeeiioouu"
## Output: ("aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu")
##
## NOTE: Updated output [2025-05-18]
#
## Example 3
##
## Input: $str = "aeiouuaxaeiou"
## Output: ("aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua")
##
## NOTE: Updated output [2025-05-18]
#
## Example 4
##
## Input: $str = "uaeiou"
## Output: ("aeiou", "uaeio", "uaeiou")
#
## Example 5
##
## Input: $str = "aeioaeioa"
## Output: ()
#
############################################################
##
## discussion
##
############################################################
#
# We create all possible substrings, then we check whether there
# are any non-vowels in them and if they contain all vowels. In
# that case, we keep them.

use v5.36;

count_vowel("aeiou");
count_vowel("aaeeeiioouu");
count_vowel("aeiouuaxaeiou");
count_vowel("uaeiou");
count_vowel("aeioaeioa");

sub count_vowel($str) {
    say "Input: \"$str\"";
    my @result = ();
    foreach my $i (0..length($str)-1) {
        foreach my $j (1..length($str)-$i) {
            my $s = substr($str, $i, $j);
            push @result, $s if has_all_vowels($s);
        }
    }
    say "Output: (" . join(", ", map { "\"$_\"" } @result) . ")";
}

sub has_all_vowels($str) {
    my %chars = ();
    map { $chars{"$_"} = 1 } split //, $str;
    return 0 if $str =~ m/[^aeiou]/;
    return 0 unless $chars{"a"};
    return 0 unless $chars{"e"};
    return 0 unless $chars{"i"};
    return 0 unless $chars{"o"};
    return 0 unless $chars{"u"};
    return 1;
}

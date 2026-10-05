#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-394/#TASK2
#
# Task 2: Alternating Vowels Consonants
# =====================================
#
# You are given three strings containing English alphabetic characters.
#
# Find all the longest contiguous substrings common to all three strings that
# strictly alternate between vowels and consonants.
#
## Example 1
##
## Input: @str = ("relocate", "delocate", "allocate")
## Output: ("locate")
#
## Example 2
##
## Input: @str = ("apple", "banana", "cherry")
## Output: ()
#
## Example 3
##
## Input: @str = ("navigate", "cavity", "gravity")
## Output: ("avi")
#
## Example 4
##
## Input: @str = ("pedalgia", "pedalboard", "pedantic")
## Output: ("peda")
#
## Example 5
##
## Input: @strings = ("schoolmaster", "schoolhouse", "schooling")
## Output: ("ho", "ol")
#
############################################################
##
## discussion
##
############################################################
#
# We pick the first word, create all possible substrings of it,
# and keep the ones that have alternating vowels and non-vowels,
# and group them by length. We then pick the list for the longest
# length.

use v5.36;
use List::Util qw(any max);
use Data::Dumper;

alternating_vowels_consonants("relocate", "delocate", "allocate");
alternating_vowels_consonants("apple", "banana", "cherry");
alternating_vowels_consonants("navigate", "cavity", "gravity");
alternating_vowels_consonants("pedalgia", "pedalboard", "pedantic");
alternating_vowels_consonants("schoolmaster", "schoolhouse", "schooling");

sub alternating_vowels_consonants($str1, $str2, $str3) {
    say "Input: \"$str1\", \"$str2\", \"$str3\"";
    my $l = length($str1);
    my $results = {};
    foreach my $i (0..$l-1) {
        foreach my $j ($i..$l-1) {
            my $s = substr($str1, $i, 1 + $j - $i);
            if(is_alternating($s) && $str2 =~ m/$s/ && $str3 =~ m/$s/) {
                next if length($s) <= 1;
                push @{$results->{length($s)}}, $s;
            }
        }
    }
    return say "Output: ()" unless keys %$results;
    my $m = max(keys %$results);
    say "Output: (" . join(", ", map { "\"$_\"" } @{$results->{$m}}) . ")";
}

sub is_alternating($str) {
    my @chars = split //, $str;
    my $last = is_vowel($chars[0]);
    foreach my $i (1..$#chars) {
        my $this = is_vowel($chars[$i]);
        if($this == $last) {
            return 0;
        }
        $last = $this;
    }
    return 1;
}

sub is_vowel($c) {
    return any { lc($c) eq $_ } qw(a e i o u);
}


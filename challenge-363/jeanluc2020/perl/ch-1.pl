#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-363/#TASK1
#
# Task 1: String Lie Detector
# ===========================
#
# You are given a string.
#
# Write a script that parses a self-referential string and determines whether
# its claims about itself are true. The string will make statements about its
# own composition, specifically the number of vowels and consonants it
# contains.
#
## Example 1
##
## Input: $str = "aa — two vowels and zero consonants"
## Output: true
#
#
## Example 2
##
## Input: $str = "iv — one vowel and one consonant"
## Output: true
#
#
## Example 3
##
## Input: $str = "hello - three vowels and two consonants"
## Output: false
#
#
## Example 4
##
## Input: $str = "aeiou — five vowels and zero consonants"
## Output: true
#
#
## Example 5
##
## Input: $str = "aei — three vowels and zero consonants"
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# We split the input into the string and the part that contains
# the amount of vowels and consonants.
# Then we first count the vowels and consonants in the string
# part. After that, we extract the counted numbers in the
# string. Now we only need to compare these numbers.

use v5.36;

string_lie_detector("aa - two vowels and zero consonants");
string_lie_detector("iv - one vowel and one consonant");
string_lie_detector("hello - three vowels and two consonants");
string_lie_detector("aeiou - five vowels and zero consonants");
string_lie_detector("aei - three vowels and zero consonants");

sub string_lie_detector($str) {
    say "Input: \"$str\"";
    my ($string, $counts) = split / - /, $str;
    my ($v_l, $c_l) = (0, 0);
    my $map = {
        "zero" => 0, "one" => 1, "two" => 2, "three" => 3, "four" => 4,
        "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9,
        "ten" => 10, "eleven" => 11, "twelve" => 12, "thirteen" => 13,
        "fourteen" => 14, "fifteen" => 15, "sixteen" => 16,
        "seventeen" => 17, "eighteen" => 18, "nineteen" => 19, "twenty" => 20
    };

    foreach my $c (split //, $string) {
        if($c =~ m/[aeiou]/) {
            $v_l++;
        } else {
            $c_l++;
        }
    }
    $counts =~ m/(\w+) vowels? and (\w+) consonants?/;
    my ($v_r, $c_r) = ($1, $2);
    if($v_l == $map->{$v_r} && $c_l == $map->{$c_r}) {
        return say "Output: true";
    }
    say "Output: false";
}

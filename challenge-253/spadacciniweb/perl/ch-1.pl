#!/usr/bin/env perl

# Task 1: Split Strings
# Submitted by: Mohammad S Anwar
# 
# You are given an array of strings and a character separator.
# Write a script to return all words separated by the given character excluding empty string.
# 
# Example 1
# Input: @words = ("one.two.three","four.five","six")
#        $separator = "."
# Output: "one","two","three","four","five","six"
# 
# Example 2
# Input: @words = ("$perl$$", "$$raku$")
#        $separator = "$"
# Output: "perl","raku"


use strict;
use warnings;

my @words = ("one.two.three","four.five","six");
my $separator = ".";
split_strings(\@words, $separator);

@words = ('$perl$$', '$$raku$');
$separator = '$';
split_strings(\@words, $separator);

exit 0;

sub split_strings {
    my $words = shift;
    my $separator = shift;

    printf "Output: \"%s\"\n", join '","', map { join '","', grep {!/^$/} split /\Q$separator\E/, $_ }
                                            @$words;

    return 0;
}

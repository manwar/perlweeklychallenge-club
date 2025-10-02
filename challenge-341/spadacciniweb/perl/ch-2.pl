#!/usr/bin/env perl

# Task 2: Reverse Prefix
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str and a character in the given string, $char.
# Write a script to reverse the prefix upto the first occurrence of the given $char in the given string $str and return the new string.
# 
# Example 1
# Input: $str = "programming", $char = "g"
# Output: "gorpmming"
# 
# Reverse of prefix "prog" is "gorp".
# 
# Example 2
# Input: $str = "hello", $char = "h"
# Output: "hello"
# 
# Example 3
# Input: $str = "abcdefghij", $char = "h"
# Output: "hgfedcbaj"
# 
# Example 4
# Input: $str = "reverse", $char = "s"
# Output: "srevere"
# 
# Example 5
# Input: $str = "perl", $char = "r"
# Output: "repl"

use strict;
use warnings;

my $str = "programming"; my $char = "g";
reverse_prefix( $str, $char );

$str = "hello", $char = "h";
reverse_prefix( $str, $char );

$str = "abcdefghij"; $char = "h";
reverse_prefix( $str, $char );

$str = "reverse"; $char = "s";
reverse_prefix( $str, $char );

$str = "perl"; $char = "r";
reverse_prefix( $str, $char );

exit 0;

sub reverse_prefix {
    my $str = shift;
    my $char = shift;

    my @str = split //, $str;
    my $new_str = '';
    foreach (1 .. length($str)) {
        my $letter = shift @str;
        $new_str .= $letter;
        if ($letter eq $char) {
            $new_str = reverse $new_str;
            last;
        }
    }
    $new_str .= join '', @str;

    printf "'%s' '%s' -> '%s'\n", $str, $char, $new_str;
}

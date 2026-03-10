#!/usr/bin/perl
use strict;
use warnings;

# Subroutine: Convert a number to its corresponding lowercase letter
# 1 -> 'a', 2 -> 'b', ..., 26 -> 'z'

sub num_to_letter {
    my $n = shift; # Get the input number
    return chr(ord('a') + $n - 1); # Convert to letter using ASCII values
}


sub decrypt_string {

    my $str = @_;

    Step 1
    # Replace two-digit numbers followed by '#' (10-26) with their corresponding letters
    # - (1[0-9]|2[0-6]) matches 10-19 or 20-26
    # - The 'e' modifier allows Perl to evaluate the replacement as code

    $str =~ s/(1[0-9]|2[0-6])#/num_to_letter($1)/eg;

    Step 2
    # Translate single digits (1-9) to their corresponding letters (a-i)
    # - tr/1-9/a-i/ performs a character-by-character translation

    $str =~ tr/1-9/a-i/;

    # For the curious the Per-golf version, that avoids tr/// completely
    # and handles everything in one pass.
    # $str =~ s/(1\d|2[0-6])#|([1-9])/chr(ord('a') + ($1||$2) - 1)/eg;

    return $str;
}

# Tests
my $str;

# Example 1
$str = "10#11#12";
printf "%s\n", decrypt_string($str); # Output: "jkab"

# Example 2
$str = "1326#";
printf "%s\n", decrypt_string($str); # Output: "acz"

# Example 3
$str = "25#24#123";
printf "%s\n", decrypt_string($str); # Output: "yxabc"

# Example 4
$str = "20#5";
printf "%s\n", decrypt_string($str); # Output: "te"

# Example 5
$str = "1910#26#";
printf "%s\n", decrypt_string($str); # Output: "aijz"

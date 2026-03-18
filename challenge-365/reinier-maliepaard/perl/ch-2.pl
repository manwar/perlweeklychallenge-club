#!/usr/bin/perl
use strict;
use warnings;

# The instruction is didactic in nature and outlines the step-by-step construction of a regular expression.

# 1. A token is valid if it contains no digits (but letters: see examples),
# /^[a-z]+$/

# - ^ -> start of the word
# - [a-z]+ -> one or more letters (lowercase)
# - $ -> end of the word
# - This regex matches: "hello", "c", but does not match: "hello,", "a-bcdef", "-oops"

# 2. has at most one hyphen surrounded by lowercase letters,
# /^[a-z]+(-[a-z]+)?$/

# - (-[a-z]+)? -> zero or one occurrences of a hyphen followed by letters
# - This regex matches: "a-bcdef", "cd-xy" but does not match words with punctuation at the end like "hello," or "c!"

# 3. and at most one punctuation mark (!, ., ,) appearing only at the end.
# /^[a-z]+(-[a-z]+)?[!.,]?$/

# - [!.,]? -> optional single punctuation character at the end (? = zero or one)
# - This regex matches: "hello,", "c!", "cd-xy!"

# So the complete regex is: /^[a-z]+(-[a-z]+)?[!.,]?$/

# Now the counting part:
# - grep works on an array
# - grep filters the words that match the regex
# - grep returns an array
# - in scalar context, grep returns the number of matches

# So the result is with space-separated tokens as input:
# my $input_str = "hello, c! a-bcdef -oops ab- cd-xy!";
# my $no_valid_words = scalar grep { /^[a-z]+(-[a-z]+)?[!.,]?$/ } split(/\s+/, $input_str);
# return $no_valid_words;
# shorter: without variable $no_valid_words and simply: return scalar grep ...

# study below: die built-in; prints message and exits with error


# Implementation

sub valid_token_counter {
    my ($input_str) = @_;
    die "Invalid input: use lowercase letters, spaces, and . , ! - only (at least one letter required)\n"
        unless $input_str =~ /^(?=.*[a-z])[a-z.,! \-]+$/; # see footnote (1)

    return scalar grep { /^[a-z]+(-[a-z]+)?[!.,]?$/ } (split /\s+/, $input_str);
}


# Tests

my $str;

# Example 1
$str = "cat and dog"
printf "%d\n", valid_token_counter($str); # Output: 3

# Example 2
$str = "a-b c! d,e"
printf "%d\n", valid_token_counter($str); # Output: 2

# Example 3
$str = "hello-world! this is fun"
printf "%d\n", valid_token_counter($str); # Output: 4

# Example 4
$str = "ab- cd-ef gh- ij!"
printf "%d\n", valid_token_counter($str); # Output: 2

# Example 5
$str = "wow! a-b-c nice."
printf "%d\n", valid_token_counter($str); # Output: 2

# Footnote
# (1): ^(?=.*[a-z]) means "Starting at the beginning, ensure that somewhere in the string there is at least one lowercase letter”

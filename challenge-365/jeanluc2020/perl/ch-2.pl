#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-365/#TASK2
#
# Task 2: Valid Token Counter
# ===========================
#
# You are given a sentence.
#
# Write a script to split the given sentence into space-separated tokens and
# count how many are valid words. A token is valid if it contains no digits,
# has at most one hyphen surrounded by lowercase letters, and at most one
# punctuation mark (!, ., ,) appearing only at the end.
#
## Example 1
##
## Input: $str = "cat and dog"
## Output: 3
##
## Tokens: "cat", "and", "dog"
#
## Example 2
##
## Input: $str = "a-b c! d,e"
## Output: 2
##
## Tokens: "a-b", "c!", "d,e"
## "a-b" -> valid (one hyphen between letters)
## "c!"  -> valid (punctuation at end)
## "d,e" -> invalid (punctuation not at end)
#
## Example 3
##
## Input: $str = "hello-world! this is fun"
## Output: 4
##
## Tokens: "hello-world!", "this", "is", "fun"
## All satisfy the rules.
#
## Example 4
##
## Input: $str = "ab- cd-ef gh- ij!"
## Output: 2
##
## Tokens: "ab-", "cd-ef", "gh-", "ij!"
## "ab-"   -> invalid (hyphen not surrounded by letters)
## "cd-ef" -> valid
## "gh-"   -> invalid
## "ij!"   -> valid
#
## Example 5
##
## Input: $str = "wow! a-b-c nice."
## Output: 2
##
## Tokens: "wow!", "a-b-c", "nice."
## "wow!"  -> valid
## "a-b-c" -> invalid (more than one hyphen)
## "nice." -> valid
#
############################################################
##
## discussion
##
############################################################
#
# We split $str into the tokens and check each token. To check
# each token, we encode the rules into a function which returns 0
# if the token is invalid and 1 if it is valid. That way, we can
# just add up all the results of is_valid() to obtain the final
# result.

use v5.36;

valid_token_counter("cat and dog");
valid_token_counter("a-b c! d,e");
valid_token_counter("hello-world! this is fun");
valid_token_counter("ab- cd-ef gh- ij!");
valid_token_counter("wow! a-b-c nice.");

sub valid_token_counter($str) {
    say "Input: \"$str\"";
    my @tokens = split /\s+/, $str;
    my $count = 0;
    foreach my $token (@tokens) {
        $count += is_valid($token);
    }
    say "Output: $count";
}

sub is_valid($token) {
    return 0 if $token =~ m/\d/;
    return 0 if $token =~ m/[!,.]./;
    return 0 if $token =~ m/-.*-/;
    return 0 if $token =~ m/[A-Z]-/;
    return 0 if $token =~ m/-[A-Z]/;
    return 0 if $token =~ m/[^\w]-/;
    return 0 if $token =~ m/-[^\w]/;
    return 0 if $token =~ m/^-/;
    return 0 if $token =~ m/-$/;
    return 1 if $token =~ m/^[\w!,.-]+$/;
    return 0;
}

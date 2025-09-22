#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-340/#TASK1
#
# Task 1: Duplicate Removals
# ==========================
#
# You are given a string, $str, consisting of lowercase English letters.
#
# Write a script to return the final string after all duplicate removals have been made. Repeat duplicate removals on the given string until we no longer can.
#
# # A duplicate removal consists of choosing two adjacent and equal letters and removing them.
#
## Example 1
##
## Input: $str = 'abbaca'
## Output: 'ca'
##
## Step 1: Remove 'bb' => 'aaca'
## Step 2: Remove 'aa' => 'ca'
#
#
## Example 2
##
## Input: $str = 'azxxzy'
## Output: 'ay'
##
## Step 1: Remove 'xx' => 'azzy'
## Step 2: Remove 'zz' => 'ay'
#
#
## Example 3
##
## Input: $str = 'aaaaaaaa'
## Output: ''
##
## Step 1: Remove 'aa' => 'aaaaaa'
## Step 2: Remove 'aa' => 'aaaa'
## Step 3: Remove 'aa' => 'aa'
## Step 4: Remove 'aa' => ''
#
#
## Example 4
##
## Input: $str = 'aabccba'
## Output: 'a'
##
## Step 1: Remove 'aa' => 'bccba'
## Step 2: Remove 'cc' => 'bba'
## Step 3: Remove 'bb' => 'a'
#
#
## Example 5
##
## Input: $str = 'abcddcba'
## Output: ''
##
## Step 1: Remove 'dd' => 'abccba'
## Step 2: Remove 'cc' => 'abba'
## Step 3: Remove 'bb' => 'aa'
## Step 4: Remove 'aa' => ''
#
############################################################
##
## discussion
##
############################################################
#
# We can use a regular expression with backreference: Replace a single
# character followed by itself with an empty string while this still
# works.

use v5.36;

duplicate_removals('abbaca');
duplicate_removals('azxxzy');
duplicate_removals('aaaaaaaa');
duplicate_removals('aabccba');
duplicate_removals('abcddcba');

sub duplicate_removals ($str) {
    say "Input: $str";
    while($str =~ s/(.)\1//) { }
    say "Output: $str";
}

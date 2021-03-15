#!/usr/bin/env perl
# Perl weekly challenge 095
# Task 1: Palindrome number.
# Figure out if a number is a palindrome.
# See https://wlmb.github.io/2021/01/11/PWC95/#task-1-palindrome-number
use v5.12;
use strict;
use warnings;
say("Input: $_\nOutput:", ("$_" eq reverse "$_")?1:0) foreach @ARGV;

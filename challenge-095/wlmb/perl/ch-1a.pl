#!/usr/bin/env perl
# Perl weekly challenge 095
# Task 1: Palindrome number. Alternative solution
# Figure out if a string is a palindrome after stripping punctuation.
# See https://wlmb.github.io/2021/01/11/PWC95/#task-1-palindrome-number
use v5.12;
use strict;
use warnings;
use English;
undef $INPUT_RECORD_SEPARATOR;
my $input=<>;
(my $clean_input=lc $input)=~s/\W//g;
say("Input:\n$input\nOutput:", ("$clean_input" eq reverse "$clean_input")?1:0);

#!/usr/bin/env perl
# Perl weekly challenge 239
# Task 1:  Same String
#
# See https://wlmb.github.io/2023/10/15/PWC239/#task-1-same-string
use v5.36;
die <<~"FIN" unless @ARGV==2;
    Usage: $0 AR1 AR2
    to check if the space separated lists of strings ARn concatenate
    to the same string.
    FIN
my @ar1=split " ", shift;
my @ar2=split " ", shift;
say "(@ar1), (@ar2) -> ", (join "", @ar1) eq (join "",@ar2)?"True":"False"

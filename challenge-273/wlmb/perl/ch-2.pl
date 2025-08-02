#!/usr/bin/env perl
# Perl weekly challenge 273
# Task 2:  B After A
#
# See https://wlmb.github.io/2024/06/10/PWC273/#task-2-b-after-a
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to test the strings S1 S2... for B after A
    FIN
for(@ARGV){
    say "$_ -> ", /^[^b]*b[^a]*$/i?"true":"false"
}

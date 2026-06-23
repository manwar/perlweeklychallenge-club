#!/usr/bin/env perl
# Perl weekly challenge 379
# Task 1:  Reverse String
#
# See https://wlmb.github.io/2026/06/22/PWC379/#task-1-reverse-string
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to reverse the string Sn
    FIN
for(@ARGV){
    my @reversed;
    unshift @reversed, $_ for split "";
    say "\"$_\" -> \"", @reversed,"\""
}

#!/usr/bin/env perl
# Perl weekly challenge 329
# Task 1:  Counter Integers
#
# See https://wlmb.github.io/2025/07/07/PWC329/#task-1-counter-integers
use v5.36;
use List::Util qw(uniqint);
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to find distinct integers within the strings Sn.
    FIN
for(@ARGV){
    say("Only lowercase letters and digits allowed: $_"), next unless /^[a-z0-9]*$/;
    say "$_ -> ", join " ", uniqint grep {!/^$/} split /[a-z]+/, $_;
}

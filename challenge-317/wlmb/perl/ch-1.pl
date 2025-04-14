#!/usr/bin/env perl
# Perl weekly challenge 317
# Task 1:  Acronyms
#
# See https://wlmb.github.io/2025/04/14/PWC317/#task-1-acronyms
use v5.36;
die <<~"FIN" unless @ARGV >= 2;
    Usage $0 T W1 W2...
    to find if T is an acronym for the list of words W1 W2...
    FIN
my $tentative=shift;
my $acronym=join "",map{substr $_,0,1}@ARGV;
say "Tentative=$tentative, Words=@ARGV -> ", lc $tentative eq lc $acronym?"True":"False";

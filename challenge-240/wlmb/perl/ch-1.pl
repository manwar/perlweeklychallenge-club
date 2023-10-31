#!/usr/bin/env perl
# Perl weekly challenge 240
# Task 1:  Acronym
#
# See https://wlmb.github.io/2023/10/23/PWC240/#task-1-acronym
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 A W1 [W2...]
    to test if A is an acronym of the words W1, W2...
    FIN
my $acronym=shift;
say "$acronym <= @ARGV: ", lc $acronym eq (lc join "", map {substr $_, 0,1} @ARGV)?"True":"False"

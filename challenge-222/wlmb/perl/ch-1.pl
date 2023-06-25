#!/usr/bin/env perl
# Perl weekly challenge 222
# Task 1:  Matching Members
#
# See https://wlmb.github.io/2023/06/19/PWC222/#task-1-matching-members
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2....]
    to count how many members of the list N1 N2... match the members of the
    corresponding sorted list
    FIN
my @sorted=sort {$a<=>$b} my @in=@ARGV;
my @out=grep {$sorted[$_]==$in[$_]} 0..@in-1;
say "@in -> ", 0+@out;

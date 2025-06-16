#!/usr/bin/env perl
# Perl weekly challenge 326
# Task 2:  Decompressed List
#
# See https://wlmb.github.io/2025/06/16/PWC326/#task-2-decompressed-list
use v5.36;
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 R1 N1 R2 N2...
    to make a list with number Ni repeated Ri times.
    FIN
my @output=();
for my($i,$j)(@ARGV){
    push @output, ($j)x$i;
}
say "@ARGV -> @output"

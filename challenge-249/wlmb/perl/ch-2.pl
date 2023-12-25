#!/usr/bin/env perl
# Perl weekly challenge 249
# Task 2:  DI String Match
#
# See https://wlmb.github.io/2023/12/25/PWC249/#task-2-di-string-match
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 [S2...]
    where S_i is a string of D's and I's, to produce a permutation of
    indices 0..length of S_i that increases or decreases according to
    the letters D or I.
    FIN
for(@ARGV){
    my @output;
    push @output,my $max=my $min=0;
    push @output, ($_ eq "D")?++$max:--$min for reverse split "";
    say "$_ => (",join(",", reverse map {$_-$min} @output), ")"
}

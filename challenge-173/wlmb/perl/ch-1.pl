#!/usr/bin/env perl
# Perl weekly challenge 173
# Task 1: Esthetic number
#
# See https://wlmb.github.io/2022/07/11/PWC173/#task-1-esthetic-number
use v5.36;
use List::Util qw(all);
say("Usage: ./ch-1.pl N1 [N2...]\nto check if N1, N2... are esthetic numbers"), exit
    unless @ARGV;
foreach(@ARGV){
    s/^\s*\+\s*//;  # remove leading +, if present
    say("Error: $_ is not a positive number"), next unless $_=~/^\d+$/;
    my ($current,@rest)=split "";
    my $test;
    say "$_ ", (
        (all {($current,$test)=($_, abs($_-$current)==1); $test}(@rest))
        ? "is"
        : "is not"
        ), " an esthetic number";
}

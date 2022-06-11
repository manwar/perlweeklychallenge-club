#!/usr/bin/env perl
# Perl weekly challenge 150
# Task 1: fibonacci words
#
# See https://wlmb.github.io/2022/01/31/PWC150/#task-1-fibonacci-words
use v5.12;
use warnings;
die "Usage: ./ch-1.pl word word [N]" .
    "to get the N-th (default=51) character of a fibonacci word"
    unless @ARGV>=2;
my ($x, $y, $N)=@ARGV;
$N//=51;
die "N should be >=1" unless $N>=1;
die "Words should not be empty"
    unless length $x > 0 && length $y > 0;
say "Fibonacci sequence:";
say($x), ($x, $y)=($y, $x . $y) until length($x)>=$N;
say $x;
say "\n$N-th letter: ", substr $x,$N-1,1;

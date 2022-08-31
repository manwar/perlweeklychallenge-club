#!/usr/bin/env perl
# Perl weekly challenge 180
# Task 2: Trim List
#
# See https://wlmb.github.io/2022/08/29/PWC180/#task-2-trim-list
use v5.36;
die "Usage: $0 N E0 E1...\nto trim the list keeping elements En>=N."
    unless @ARGV>=2;
my ($N, @list)=@ARGV;
say "The elements of (", join(", ", @list),
    ") larger than or equal to $N are (",
    join(", ", grep {$_ >= $N} @list), ")";

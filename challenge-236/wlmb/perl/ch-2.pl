#!/usr/bin/env perl
# Perl weekly challenge 236
# Task 2:  Array Loops
#
# See https://wlmb.github.io/2023/09/24/PWC236/#task-2-array-loops
use v5.36;
my @in=@ARGV;
my @seen;
my $count=0;
for(0..@in-1){ #for each possible starting index
    $seen[my $next=$_]++;
    1 while 0<=$next <@in && !$seen[$next=$in[$next]]++;
    ++$count if $next==$_;
}
say "@in -> $count";

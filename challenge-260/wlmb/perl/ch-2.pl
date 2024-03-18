#!/usr/bin/env perl
# Perl weekly challenge 260
# Task 2:  Dictionary Rank
#
# See https://wlmb.github.io/2024/03/10/PWC260/#task-2-dictionary-rank
use v5.36;
use Algorithm::Combinatorics qw(permutations);
use List::AllUtils qw(uniq onlyidx);
die <<~"FIN" unless @ARGV;
    Usage: $0 W1 [W2...]
    to find the dictionary rank of words W1 W2...
    FIN
for(@ARGV){
    my @letters=split "", my $word=lc;
    say "$_ => ", 1+onlyidx {$_ eq $word}
         sort{$a cmp $b}
         uniq
	 map {join "", @$_}
         permutations(\@letters);
}

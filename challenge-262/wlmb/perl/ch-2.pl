#!/usr/bin/env perl
# Perl weekly challenge 262
# Task 2:  Count Equal Divisible
#
# See https://wlmb.github.io/2024/03/24/PWC262/#task-2-count-equal-divisible
use v5.36;
die <<~"FIN" unless @ARGV>=2;
    Usage: $0 K N1 [N2...]
    to count pairs N_i==N_j where K divides i*j
    FIN
my ($k,@ints)=@ARGV;
my $count=0;
for my $i(0..@ints-2){
    for ($i+1..@ints-1){
	++$count if $ints[$i]==$ints[$_] && ($i*$_)%$k==0;
    }
}
say "k=$k, ints=@ints -> $count";

#!/usr/bin/env perl
# Perl weekly challenge 202
# Task 1:  Consecutive Odds
#
# See https://wlmb.github.io/2023/01/30/PWC202/#task-1-consecutive-odds
use v5.36;
my $out=0;
my ($u, $d, $t);
for(sort {$a <=> $b} grep {$_%2} @ARGV){
    ($u,$d,$t)=($d,$t,$_); # Current three elements
    $out=1, last if $u+4==$d+2==$t
}
say(join " ", @ARGV, "-> $out");

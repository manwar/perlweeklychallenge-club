#!/usr/bin/env perl
# Perl weekly challenge 342
# Task 2:  Max Score
#
# See https://wlmb.github.io/2025/10/06/PWC342/#task-2-max-score
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 B1 B2...
    to split the binary strings Bi maximizing the number of zeroes
    on the left side plus the number of ones on the right side.
    FIN
for(@ARGV){
    warn("Only 0's and 1's permitted in binary string: $_"), next unless /^(0|1)*$/;
    warn("Need at least two digits in string: $_"), next unless length >= 2;
    my $left=substr my $right=$_,0,1,"";
    my $score=($left==0)+((my $tmp=$right)=~tr/1/0/); # initial score
    my @scores=($score);
    push @scores, $score+=length($2)-length($1) while $right=~s/^(1*)(0+)(\d)/$3/;
    say "$_ -> ", max @scores;
}

#!/usr/bin/env perl
# Perl weekly challenge 316
# Task 2:  Subsequence
#
# See https://wlmb.github.io/2025/04/07/PWC316/#task-2-subsequence
use v5.36;
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 S11 S12 S21 S22...
    to find if the strings strings Sn1 are a subsecuence of Sn2 or viceversa
    FIN
for my ($x,$y)(@ARGV){
    say "$x $y -> ", subsec($x,$y)||subsec($y,$x)?"True":"False";
}
sub subsec($x,$y){
    my $re = join ".*", split "", $x;
    $y=~/$re/;
}

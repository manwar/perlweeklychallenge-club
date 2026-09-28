#!/usr/bin/env perl
# Perl weekly challenge 393
# Task 2:  Prime Step
#
# See https://wlmb.github.io/2026/09/28/PWC393/#task-2-prime-step
use v5.36;
use Math::Prime::Util qw(next_prime prev_prime is_prime);
use List::Util qw(min sum0);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the distance between the sum of the ordinal
    values of the string Si and the closest prime number.
    FIN
for(@ARGV){
    my $sum = sum0 map {ord} split"";
    say "$_ -> ",
	is_prime $sum?
	0 :
	min $sum - prev_prime($sum), next_prime($sum)-$sum
}

#!/usr/bin/env perl
# Perl weekly challenge 156
# Task 1: Pernicious numbers
#
# See https://wlmb.github.io/2022/03/14/PWC156/#task-1-pernicious-numbers
use v5.12;
use warnings;
use bigint;
use Math::Prime::Util qw(is_prime);
use List::Util qw(sum0);
my $N=shift//10; # How many pernicious numbers to calculate
my $candidate=0;
my @pernicious;
for(1..$N){
    push(@pernicious, $candidate), next
        if is_prime(sum0 split "", sprintf "%b", ++$candidate);
    redo
}
say "The first $N pernicious numbers are ", join ", ",  @pernicious;

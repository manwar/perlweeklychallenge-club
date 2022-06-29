#!/usr/bin/env perl
# Perl weekly challenge 171
# Task 1: Abundant number
#
# See https://wlmb.github.io/2022/06/27/PWC171/#task-1-abundant-number
use v5.12;
use warnings;
use PDL;
die "Usage ./ch-1.pl N\nto obtain the first N abundant odd numbers" unless @ARGV;
my $count=shift; # How many abundants are desired
my $candidate=1;
while($count){
    $candidate+=2; # only test odd numbers
    my $potential_divisors=1+sequence($candidate/2);
    my $divisors=$potential_divisors->where($candidate%$potential_divisors==0);
    my $sum=$divisors->sumover;
    $count--, say "$candidate: Divisors: $divisors. Sum: $sum." if $sum>$candidate;
}

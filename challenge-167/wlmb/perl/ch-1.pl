#!/usr/bin/env perl
# Perl weekly challenge 167
# Task 1: Circular prime
#
# See https://wlmb.github.io/2022/05/30/PWC167/#task-1-circular-prime
use v5.12;
use warnings;
use Math::Prime::Util qw(next_prime is_prime);
use List::Util qw(all);
my $count=0;
my $candidate=99;
my $desired=shift//10; # allow reading number of circular primes from @ARGV
say "You are too voracious; next time choose a number <=10" unless $desired <=10;
$desired=10 if $desired >10;
my %seen;
my @found;
while($count < $desired){
    next if $seen{$candidate=next_prime($candidate)};
    my @digits=split "", $candidate;
    map {$seen{$_}=1}
        my @cyclic=map {join "",@digits[$_..@digits-1],@digits[0..$_-1]} (0..@digits-1);
    push(@found, $candidate), ++$count if all {is_prime($_)} @cyclic;
}
say join " ","The first $desired decimal circular primes are:", @found;

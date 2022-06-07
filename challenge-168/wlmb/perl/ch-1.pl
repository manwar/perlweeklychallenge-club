#!/usr/bin/env perl
# Perl weekly challenge 168
# Task 1: Perrin prime
#
# See https://wlmb.github.io/2022/06/06/PWC168/#task-1-perrin-prime
use v5.12;
use warnings;
use bigint;
use Math::Prime::Util qw(is_prime);
die "Usage: $0 N\n to write the first N Perrin Primes" unless @ARGV;
my $N=shift;
my @last_perrins=(3,0,2);
my @perrin_primes;
my %seen;
while(@perrin_primes<$N){
    push @last_perrins, my $perrin=$last_perrins[-3]+$last_perrins[-2];
    shift @last_perrins; # no need to keep old Perrins
    $seen{$perrin}=1, push @perrin_primes, $perrin if is_prime($perrin) and !$seen{$perrin};
}
say join " ", sort {$a<=>$b} @perrin_primes;

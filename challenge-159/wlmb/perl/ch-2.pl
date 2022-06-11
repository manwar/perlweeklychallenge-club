#!/usr/bin/env perl
# Perl weekly challenge 159
# Task 2: Moebius number
#
# See https://wlmb.github.io/2022/04/05/PWC159/#task-2-moebius-number
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
die "Usage: ./ch-2.pl N1 [N2... ]\n to find the Moebius numbers of N1, N2..." unless @ARGV;
for(@ARGV){
    my $sieve=ones($_+1); # Eratosthenes sieve
    $sieve(0:1).=0;
    $sieve($_**2:-1:$_).=0 for(2..sqrt($_)); # 1=prime, 0=nonprime
    my $primes=$sieve->xvals->where($sieve); # primes
    my $factors=$primes->where($_%$primes==0); # prime factors
    my $prod=$factors->prodover; # product of factors, once each
    my $square_free=$prod==$_;
    my $parity=$factors->nelem%2?-1:1;
    say "Input: $_ Output: ", $square_free?$parity:0;
}

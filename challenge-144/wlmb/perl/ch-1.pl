#!/usr/bin/env perl
# Perl weekly challenge 144
# Task 1: Semiprime
#
# See https://wlmb.github.io/2021/12/22/PWC144/#task-1-semiprime
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
my $N=shift//100; # get upper limit from command line
my $sieve=ones($N+1); #Erastothenes sieve
$sieve(0:1).=0; #0 and 1 are not primes
$sieve($_**2:-1:$_).=0 for(2..sqrt($N)); #remove non-primes
my $primes=$sieve->xvals->where($sieve);
my $pairs=cat($primes, $primes(*))->mv(-1,0); # pairs of primes
my $sp=$pairs->prodover; # semiprimes
my ($p1, $p2, $semiprimes)=where($pairs((0)), $pairs((1)), $sp,
               ($sp->xvals>=$sp->yvals)&($sp<100));
my $indx=$semiprimes->qsorti; # order results
my ($p1_o,$p2_o,$semiprimes_o)=map {$_->($indx)} ($p1, $p2, $semiprimes);
say "The semiprimes not greater than $N are";
say $semiprimes_o(($_)), "=", $p1_o(($_)), "*", $p2_o(($_))
    foreach 0..$indx->nelem-1;

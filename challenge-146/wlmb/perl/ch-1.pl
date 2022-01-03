#!/usr/bin/env perl
# Perl weekly challenge 146
# Task 1: 10001st prime
#
# See https://wlmb.github.io/2022/01/03/PWC146/#task-1-10001st-prime
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
for my $N(@ARGV?@ARGV:10001){
    die "Argument should be positive" unless $N>=1;
    # Estimate size $M of required sieve by solving $M/log($M) approx $N
    # unless $N is too small
    my $M=$N<4?6:find_zero(sub {my $x=shift; $N-$x/log($x)},
			sub {my $l=log($_[0]); 1/$l**2-1/$l}, $N);
    my $sieve=ones($M); # fill sieve with ones
    $sieve(0:1).=0; # 0 and 1 are not primes
    $sieve($_*$_:-1:$_).=0 foreach(2..sqrt($M-1)); # multiples of 'it' are not prime
    my $primes=$sieve->xvals->where($sieve); # first primes
    die "Short sieve" unless $N<=$primes->nelem; # shouldn't happen
    say "$N-th prime is ", $primes(($N-1));
}

no PDL::NiceSlice; # NiceSlice destroys indirect function calls!
sub find_zero { # Find zero of function using Newton's iteration
    my ($f, $d, $x)=@_; # function, derivative, initial guess
    my $y;
    my $max=10; # guard against non-convergence
    do{($y, $x)= ($x, $x-$f->($x)/$d->($x))} until approx($y,$x) or --$max<=0;
    return $x;
}

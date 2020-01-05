#!/usr/bin/perl6
use v6;

use Test;


=begin pod

TASK #1
Write a script to display attractive number between 1 and 50.
A number is an attractive number if the number of its prime factors is also prime number.

The number 20 is an attractive number, whose prime factors are 2, 2 and 5. The total prime factors is 3 which is also a prime number.

=end pod

# Factorize prime number
my @primes = lazy (2,3,*+2 ... ∞).grep: *.is-prime;

say "List of Attractive Numbers from 1 to 50";
say "$_ => "~attractiveNumber($_) for 1..50;



sub attractiveNumber($n, $verbose=False) {
    # 0th candidate number not useful
    # 1st is 2
    # 2nd is ? not 3 as prime so... start looking for candidates at 4
    state @aN = 0,2;
    state $cand=4;
    say "Seeking {$n}th attractive Number " if $verbose;
    return @aN[$n] if @aN[$n]; # return the nth attractiveNumber if we have seen it!
    my $numfactors;
    loop {
        if $cand.is-prime { $cand++; next }
        print "Selecting $cand ..." if $verbose;
        $numfactors=factors($cand).elems;
        last if $numfactors.is-prime; # found attractiveNumber so finish
        say " has $numfactors factors (NOT prime)" if $verbose;
        $cand++; # keep looking
    }
    say " has $numfactors factors (prime)" if $verbose;
    @aN[$n]=$cand;
    $cand++; # inc for next time
    return @aN[$n];
}


sub factors(Int $number) {
    my @factors;
    my $n = $number;
    my $i=0;
    while $n>1 {
        my $p=@primes[$i];
        #say "{$i}th prime is  -> $p";
        if $n %% $p {
            @factors.push: $p;
            $n/=$p;
            #say "found $p, now n is $n";
            next
        };
        $i++;
    }
    @factors;
}

#!/usr/bin/perl6
use v6;

use Test;

# 23.2 Create a script that prints Prime Decomposition of a given number. The prime decomposition of a number is defined as a list of prime numbers which when all multiplied together, are equal to that number. For example, the Prime decomposition of 228 is 2,2,3,19 as 228 = 2 * 2 * 3 * 19.

my @primes =  (2,3,*+2 ... ∞).grep: *.is-prime;

#| Prime Decomosition of given integer N where N>1
multi MAIN(Int $n where $n > 1 ) {
    say primeDecompose($n, True);
}

multi MAIN("test") {
    is primeDecompose(228),[2,2,3,19],"decomposes 228";
    done-testing;
}

sub primeDecompose( $n is copy, Bool $progress=False) {
    my @answer;
    my Int $i=0;
    print "Searching: ." if $progress;
    while $n>1 {
        # if $n is a prime divisor, add to result, but stay with this prime to check again...
        if $n %% @primes[$i] {
            $n /= @primes[$i];
            @answer.push( @primes[$i] );
            print "." if $progress;
            next;
        }

        # Primality check gives a significant speed up with larger ints when $n decomposes with a large prime...
        # however large numbers are very hard to factorise!!!
        if $n.is-prime {
            @answer.push( $n );
            last;
        }

        # move on to next prime...
        $i++; # test next prime
    }
    print "\n" if $progress;
    return @answer;
}


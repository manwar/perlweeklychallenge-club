#!/usr/bin/env raku

say prime-sum 9;

sub prime-sum(Int $number where * ≥ 2) {
    return $number if $number.is-prime;

    my @primes = grep *.is-prime, 2, |(3, 5 ... $number);
    for 2..* -> $count {
    	.return if .sum == $number for [X] @primes xx $count;
    }
}

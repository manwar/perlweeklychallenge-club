#!/usr/bin/env raku

=begin pod

Week 147:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-147

Task #1: Truncatable Prime

    Write a script to generate first 20 left-truncatable prime numbers in base 10.

=end pod

use Test;

is-deeply(
    left-truncatable-primes(20),
    [ 2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 113, 137, 167, 173, 197 ],
    'Example'
);

done-testing;

#
#
# METHODS

sub left-truncatable-primes(Int $count) {
    my $ltp   = [];
    my Int $c = 0;
    my Int $n = 2;
    while $c < $count {
        if $n !~~ /0/ && $n.is-prime {
            my @n = left-truncatable-numbers($n);
            my Bool $found = True;
            if @n.elems >= 2 {
                for @n -> $_n {
                    $found = False unless $_n.is-prime;
                }
            }
            if ($found) {
                $ltp.push: $n;
                $c++;
            }
        }
        $n++;
    }

    return $ltp;
}

sub left-truncatable-numbers(Int $n) {

    my @n = ();
    my Int $i = 0;
    while $i < $n.codes {
        @n.push: substr($n, $i);
        $i++;
    }

    return @n;
}

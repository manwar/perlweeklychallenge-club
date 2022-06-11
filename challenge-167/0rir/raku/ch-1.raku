#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

=begin comment
Task 1: Circular Prime

Find the first 10 circular primes having at least 3 digits.
A circular prime is a prime number with the property that the
number generated at each intermediate step when rotating its
(base 10) digits will also be prime.
=end comment

my %seen;
my constant @circular-prime = gather for 100 … ∞ -> $n {
    if $n.is-prime {
        next if %seen{$n}:exists;
        my @a = $n.split('', :skip-empty);
        my @u = @a.unique.sort;

        next unless @u.join ~~ / ^ <[ 1 3 7 9 ]>**2..*  $ / ;

        my @circle;
        for 1 .. @a.end {
            @circle.push: join( '', @a = @a.rotate(1));
        }
        if  @circle.all.is-prime {
            for @circle { %seen{$_} = 1; }
            take $n;
        }
    }
}
say @circular-prime[ 0..9].join( ', ');
die unless @circular-prime[ 0..9].join( ', ')
    eq '113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933';

exit;

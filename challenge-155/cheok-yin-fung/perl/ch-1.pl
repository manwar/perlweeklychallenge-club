#!/usr/bin/perl
# The Weekly Challenge 155
# Task 1 Fortunate Numbers
use v5.22.0;
use warnings;
use List::Util qw 'uniqint';
use Math::BigInt;
use Math::Prime::Util 'is_prime';

my $N = $ARGV[0] || 8;

my @primes = (2, 3);
my @primorials = ( Math::BigInt->new(2), Math::BigInt->new(6) );
my @fort_unsort = (3);
my @fort_sorted = (3);

iter_prime() while scalar @primes < $N;



while (scalar @fort_sorted < $N) {
    my $k = scalar @primorials - 1;
    my $tmp_int = $primes[$k];
    do { 
        $tmp_int++;
    } while (!is_prime( $primorials[-1] + $tmp_int ));
    push @fort_unsort, $tmp_int;
    iter_primorial();
    @fort_sorted = uniqint sort {$a<=>$b} @fort_unsort;

}



while ( $fort_sorted[$N-1] > $primes[-1]) {
    iter_primorial();
    iter_prime() while scalar @primes <= scalar @primorials;
    my $k = scalar @primorials - 1;
    my $tmp_int = $primes[$k];
    do { 
        $tmp_int++;
    } while (!is_prime( $primorials[-1] + $tmp_int ));
    push @fort_unsort, $tmp_int;
    @fort_sorted = uniqint sort {$a<=>$b} @fort_unsort;
}


say "Answer: \n", join ", ", @fort_sorted[0..$N-1];


# check against OEIS:A046066
# $N =  8, $fort_sorted[$N-1] =  37
# $N = 16, $fort_sorted[$N-1] = 101
# $N = 38, $fort_sorted[$N-1] = 313



sub iter_prime {
    my $new_int = $primes[-1];
    do {
        $new_int++;
    } while (!is_prime($new_int));
    push @primes, $new_int;
}



sub iter_primorial {
    while (scalar @primes <= scalar @primorials) {
        iter_prime();
    }
    push @primorials, 
        $primorials[-1]*$primes[ scalar @primorials ];
}

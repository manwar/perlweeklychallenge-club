#!/usr/bin/perl
# The Weekly Challenge 155
# Task 1 Fortunate Numbers
use v5.22.0;
use warnings;
use List::Util qw 'uniqint';
use Math::BigInt;
use Math::Prime::Util 'is_prime';

my $N = $ARGV[0] || 8;

my @ch_primes = (2);
my @primorials = ( Math::BigInt->new(2) );
my @fort_unsort = ();
my @fort_sorted = ();



while ( !defined($fort_sorted[$N-1]) 
               ||
        $fort_sorted[$N-1] > $ch_primes[-1]
) {
    my $k = scalar @fort_unsort;
    my $tmp_int = $ch_primes[$k];
    do { 
        $tmp_int++;
    } while (!is_prime( $primorials[$k] + $tmp_int ));
    push @fort_unsort, $tmp_int;
    iter_primorial() while scalar @primorials <= scalar @fort_unsort;
    iter_prime() while scalar @ch_primes <= scalar @primorials;
    @fort_sorted = uniqint sort {$a<=>$b} @fort_unsort;
}

say "Answer: \n", join ", ", @fort_sorted[0..$N-1];


# check against OEIS:A046066
# $N =  8, $fort_sorted[$N-1] =  37
# $N = 16, $fort_sorted[$N-1] = 101
# $N = 38, $fort_sorted[$N-1] = 313



sub iter_prime {
    my $new_int = $ch_primes[-1];
    do {
        $new_int++;
    } while (!is_prime($new_int));
    push @ch_primes, $new_int;
}



sub iter_primorial {
    iter_prime() while scalar @ch_primes <= scalar @primorials;
    push @primorials, 
      $primorials[-1]*$ch_primes[ scalar @primorials ];
}

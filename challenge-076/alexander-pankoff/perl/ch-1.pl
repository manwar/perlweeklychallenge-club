#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures say state);
no warnings qw(experimental::signatures);

use Scalar::Util qw(looks_like_number);
use List::Util qw(any first);
use Memoize;

memoize( 'is_prime' );

my ( $N ) = @ARGV;

if ( $N =~ m/\D/ ) {
    usage();
    exit 1;
}

my ( $number_of_primes_used, $primes_used ) = minimum_primes( $N );

say $number_of_primes_used;
say 'Primes used: ' . join( ', ', @$primes_used ) if $ENV{DEBUG};

sub minimum_primes ( $N ) {
    if ( $N < 2 ) {
        die "cannot construct numbers smaller than 2 from a sum of primes";
    }

    if ( is_prime( $N ) ) {
        return ( 1, [$N] ) if is_prime( $N );
    }
    elsif ( $N % 2 == 0 ) {
        my $prime_gen = new_prime_gen( $N );
        while ( 1 ) {
            my $prime = $prime_gen->();
            if ( is_prime( $N - $prime ) ) {
                return ( 2, [ $N - $prime, $prime ] );
            }
        }
    }
    elsif ( is_prime( $N - 2 ) ) {
        return ( 2, [ 2, $N - 2 ] );
    }
    else {
        my $is_even = $N - 3;
        my ( $count, $primes_used ) = minimum_primes( $is_even );
        return ( $count + 1, [ 3, @$primes_used ] );
    }
}

sub new_prime_gen($max) {
    return sub {
        state $last = 0;
        $last = first { is_prime( $_ ) } ( $last + 1 ) .. $max;
        return $last;
    }
}

sub is_prime ( $n ) {

    return 0 if $n <= 1;
    return 1 if $n <= 3;
    return 0 if any { $n % $_ == 0 } ( 2, 3 );

    my $i = 5;
    while ( $i * $i <= $n ) {
        return 0 if $n % $i == 0;
        $i = $i + 2;
    }

    return 1;
}

sub usage() {
    say <<"END";
$0 <N>

  Calculate the minimum number of prime numbers required, whose summation gives N
  <N> a positive integer >= 2
END
}

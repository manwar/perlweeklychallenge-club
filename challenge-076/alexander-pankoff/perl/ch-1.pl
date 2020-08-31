#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures say);
no warnings qw(experimental::signatures);

use Scalar::Util qw(looks_like_number);
use List::Util qw(any first);
use Memoize;

memoize( '_minimum_primes' );

my ( $N ) = @ARGV;

if ( !looks_like_number( $N ) || $N < 2 ) {
    usage();
    exit 1;
}

my ( $number_of_primes_used, $primes_used ) = minimum_primes( $N );

say $number_of_primes_used;
say 'Primes used: ' . join( ', ', @$primes_used ) if $ENV{DEBUG};

sub minimum_primes($N) {
    my @primes_up_to_n = primes( $N );
    _minimum_primes( $N, \@primes_up_to_n );
}

sub _minimum_primes ( $N, $primes ) {
    return ( 1, [$N] ) if any { $N == $_ } @$primes;

    my $minimum = undef;
    my $used    = [];
    for my $i ( grep { $_ <= $N } @$primes ) {
        my ( $count, $acc ) = _minimum_primes( $N - $i, $primes );
        next if !$count;

        if ( !$minimum || $count < $minimum ) {
            $minimum = $count + 1;
            $used    = [ @$acc, $i ];
        }
    }

    return ( $minimum, $used );
}

sub primes($max) {
    grep { is_prime( $_ ) } 0 .. $max;
}

sub is_prime {
    my ( $n ) = @_;

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
  <N> a positive number >= 2
END
}

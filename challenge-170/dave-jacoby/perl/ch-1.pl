#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ product uniq };

$| = 1;
map { primorial($_) } 0 .. 9;

sub primorial ( $n ) {
    my @primes = primes($n);
    my $primes = join 'x', @primes;
    my $p      = product @primes;
    say <<"END";
        P($n) = $p ($primes)
END
}

sub primes ( $i ) {
    state $primes;
    $primes->[0] = 1;

    if ( !defined $primes->[$i] ) {
        my $iter = make_iterator( $primes->[-1] );
        while ( my $p = $iter->() ) {
            next unless is_prime($p);
            push $primes->@*, $p;
            $primes->@* = uniq $primes->@*;
            last if defined $primes->[$i];
        }
    }
    return $primes->@[ 0 .. $i ];
}

sub is_prime ($n) {
    die "Bad number $n" unless length $n;
    return 0 if $n == 0;
    return 0 if $n == 1;
    for ( 2 .. sqrt $n ) { return 0 unless $n % $_ }
    return 1;
}

sub make_iterator($n) {
    return sub {
        state $v = $n;
        return $v++;
    }
}


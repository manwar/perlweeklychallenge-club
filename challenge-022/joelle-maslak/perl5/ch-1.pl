#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

use Memoize;

die("Usage: $0 <number of sequence elements>") unless @ARGV <= 1;
my $length = $ARGV[0] // 10;

# Reused some of solution 15 (the prime function)

sub MAIN() {
    say "Primes:";
    say join( " ", $_->@* ) for ( sexy($length) );
    return;
}

sub sexy($count) {
    my @return;

    my $i = 0;
    while ( scalar(@return) < $count ) {
        $i++;

        if ( perl_isprime( prime($i) + 6 ) ) {
            push @return, [ prime($i), prime($i) + 6 ];
        }
    }

    return @return;
}

MAIN();

sub prime($i) {
    state @primes = ( 2, 3 );

    prime( $i - 1 ) if $i > scalar(@primes);
    return $primes[$i] if $i < scalar(@primes);

    my $last = $primes[-1];
    do { $last += 2 } until perl_isprime($last);

    push @primes, $last;
    return $last;
}

memoize('perl_isprime');

sub perl_isprime($i) {
    my $sqrt = int( sqrt($i) );

    if ( $i <= 2 )     { return 0; }    # negatives are wrong, at least for us
    if ( $i % 2 == 0 ) { return 0; }

    my $div = 3;
    while ( $div <= $sqrt ) {
        if ( $i % $div == 0 ) { return 0; }

        $div += 2;                      # Test just evens
    }

    return 1;
}

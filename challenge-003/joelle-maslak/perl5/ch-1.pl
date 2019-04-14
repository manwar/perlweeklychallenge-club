#!/usr/bin/env perl

use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

if ( !@ARGV )                      { die("Provide number of hamming numbers to return") }
if ( $ARGV[0] < 0 )                { die("Must provide a positive number") }
if ( int( $ARGV[0] ) != $ARGV[0] ) { die("Must provide an integer") }

my $count = $ARGV[0];

my @hamming;
while ( scalar(@hamming) < $count ) {
    state $i = 1;

    push @hamming, $i if ( ishamming($i) );

    $i++;
}

say "Hamming numbers [0.." . ($count-1) . "]: " . join( ", ", @hamming );

sub ishamming($i) {
    my @primes      = primedivisors($i);
    my @smallprimes = grep { $_ <= 5 } @primes;

    if ( @primes == @smallprimes ) {
        return 1;
    } else {
        return;
    }
}

sub primedivisors($i) {
    my %primes;

    my @divisors = divisors($i);
    if ( scalar(@divisors) <= 2 ) { $primes{$i} = 1 }

    while ( my $div = shift @divisors ) {
        if ( $div == 1 )  { next; }
        if ( $div == $i ) { next; }

        my @divdivs = divisors($div);
        if ( @divdivs <= 2 ) {    # Prime
            $primes{$div} = 1;
        } else {
            my @newdivs = primedivisors($div);
            foreach my $prime (@newdivs) {
                $primes{$prime} = 1;
            }
        }
    }

    return sort { $a <=> $b } keys %primes;
}

sub divisors($i) {
    state $cache = { 0 => [] };
    if ( ref($i) eq 'ARRAY' ) { confess("WHAT?") }

    if ( $i < 0 )        { die("Must provide a postiive integer") }
    if ( int($i) != $i ) { die("Must provide a positive integer") }

    if ( defined( $cache->{$i} ) ) { return @{ $cache->{$i} } }

    my $sqrt = int( sqrt($i) );

    my @divs = grep { !( $i % $_ ) } 1 .. $sqrt;
    push @divs, map { int( $i / $_ ) } @divs;

    $cache->{$i} = \@divs;
    return @divs;
}


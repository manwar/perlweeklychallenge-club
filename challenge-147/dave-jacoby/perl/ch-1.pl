#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

my %primes;
my %trunc;
my $c = 1;
my $n = 2;

while (1) {
    if ( $n !~ /0/mx && is_prime($n) ) {
        $primes{$n}++;
        my $copy = $n;
        while ( length $copy > 0 ) {
            last unless $primes{$copy};
            substr( $copy, 0, 1 ) = '';
            if ( $copy eq '' ) {
                $trunc{$n}++ if $copy eq '';
                last;
            }
        }
        last if scalar keys %trunc > 30;
    }
    $n++;
}

say join ', ', sort { $a <=> $b } keys %trunc;

sub is_prime ($n) {
    for ( 2 .. sqrt $n ) { return unless $n % $_ }
    return 1;
}

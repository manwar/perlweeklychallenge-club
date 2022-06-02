#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my $top = 10;
my $c   = 100;
my %next;
my @primes;

OUTER: while ( scalar @primes < $top ) {
    $c++;
    next if $next{$c};
    if ( is_prime($c) ) {
        my @permutes = circular_permutes($c);
        my $f        = 0;
        for my $p (@permutes) { $next{$p}++; $f++ if is_prime($p); }
        next OUTER unless length $c == $f;
        push @primes, $c;
        sleep 1;
    }
}
say join ', ', @primes;

sub circular_permutes ( $n ) {
    my @output;
    for my $i ( 1 .. length $n ) {
        my $d = $n;
        my $x = substr $d, 0, $i;
        substr( $d, 0, $i ) = '';
        $d .= $x;
        push @output, $d;
    }
    return @output;
}

sub is_prime ($n) {
    die "Bad number $n" unless length $n;
    return 0 if $n == 0;
    return 0 if $n == 1;
    for ( 2 .. sqrt $n ) { return 0 unless $n % $_ }
    return 1;
}

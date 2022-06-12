#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @perrin = ( 3, 0, 2 );
my %perrin_primes;
$perrin_primes{2} = 1;
$perrin_primes{3} = 1;

while ( scalar keys %perrin_primes < 13 ) {
    my $x = $perrin[-2] + $perrin[-3];
    push @perrin, $x;
    $perrin_primes{$x} = 1 if is_prime($x);
}

say join ' ', sort { $a <=> $b } keys %perrin_primes;
exit;

sub is_prime ($n) {
    die "Bad number $n" unless length $n;
    return 0 if $n == 0;
    return 0 if $n == 1;
    for ( 2 .. sqrt $n ) { return 0 unless $n % $_ }
    return 1;
}


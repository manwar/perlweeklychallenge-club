#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use List::Util qw{ uniq };

my @primes;

# redo as iterator?
my @padovan;
push @padovan, 1, 1, 1;
while ( scalar @primes < 10 ) {
    my $n = $padovan[-3] + $padovan[-2];
    push @padovan, $n;
    push @primes,  $n if is_prime($n);
    @primes = uniq @primes;
}

say join ' ', @primes;

sub is_prime ($n) {
    for ( 2 .. sqrt $n ) { return unless $n % $_ }
    return 1;
}

#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my $iter = make_iterator(2);
my @brilliant;

while ( my $i = $iter->() ) {
    push @brilliant, $i if is_brilliant($i);
    last if scalar @brilliant >= 20;
}
say join ', ', @brilliant;

sub is_brilliant( $n ) {
    my @factors = get_factors($n);

    # two prime factors
    return 0 unless scalar @factors == 2;

    # same length
    return 0 unless length $factors[0] == length $factors[1];
    return 1;
}

sub is_prime ($n) {
    die "Bad number $n" unless length $n;
    return 0 if $n == 0;
    return 0 if $n == 1;
    for ( 2 .. sqrt $n ) { return 0 unless $n % $_ }
    return 1;
}

sub get_factors( $n ) {
    my @factors;
    for my $i ( 2 .. $n ) {
        next unless $n % $i == 0;
        while ( $n % $i == 0 ) {
            push @factors, $i;
            $n = $n / $i;
        }
    }
    return @factors;
}

sub make_iterator($n) {
    return sub {
        state $v = $n;
        return $v++;
    }
}


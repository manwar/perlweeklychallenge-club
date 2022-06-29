#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum0 };

$| = 1;

#  abundant odd number
my @abundant;
my $iter = make_iterator(945);
while ( my $i = $iter->() ) {
    next if $i % 2 == 0;
    next unless is_abundant($ i );
    push @abundant, $i;
    last if scalar @abundant >20;
}

say join ' ', @abundant;

sub is_abundant( $n ) {
    my @factors = get_factors($n);
    my $sum     = sum0 @factors;
    return $sum > $n ? 1 : 0;
}

sub get_factors( $n ) {
    my @factors;
    for my $i ( 1 .. 1 + $n / 2 ) {
        next unless $n % $i == 0;
        push @factors, $i;
    }
    return @factors;
}

sub make_iterator($n) {
    return sub {
        state $v = $n;
        return $v++;
    }
}


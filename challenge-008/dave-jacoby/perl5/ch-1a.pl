#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures  };
no warnings qw{ experimental::signatures };

use List::Util qw{sum};

say join "\n", perfect_numbers();

sub perfect_numbers {
    my @numbers;
    my $p = 1;

    while ( scalar @numbers < 5 ) {
        $p++;
        next unless is_prime($p);
        my $q = $p - 1;
        my $o = ( 2**$q ) * ( ( 2**$p ) - 1 );
        next unless is_perfect($o);
        push @numbers, $o;
    }
    return @numbers;
}

sub is_perfect ( $n ) {
    my @factors = factor($n);
    my $sum     = sum @factors;
    return $sum == $n ? 1 : 0;
}

sub is_prime ( $n ) {
    my @factors = factor($n);
    return scalar @factors == 1 ? 1 : 0;
}

sub factor ( $n ) {
    my @factors;
    for my $i ( 1 .. $n - 1 ) {
        push @factors, $i if $n % $i == 0;
    }
    return @factors;
}


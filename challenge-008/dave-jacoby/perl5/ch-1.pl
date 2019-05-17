#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures  };
no warnings qw{ experimental::signatures };

use List::Util qw{sum};

say join "\n", perfect_numbers();

sub perfect_numbers {
    my @numbers;
    my $n = 0;

    while ( scalar @numbers < 5 ) {
        $n++;
        next unless $n % 2 == 0; # they're all even, so this halves time
        my @factors = factor($n);
        my $sum     = sum @factors;
        push @numbers, $n if $sum eq $n;
    }
    return @numbers;
}

sub factor ( $n ) {
    my @factors;
    for my $i ( 1 .. $n - 1 ) {
        push @factors, $i if $n % $i == 0;
    }
    return @factors;
}

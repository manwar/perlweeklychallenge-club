#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util qw(min);

sub _gcd {
    my ( $m, $n ) = @_;
    my $max = min( $m, $n );
    for ( my $c = min( $m, $n ) ; $c >= 1 ; $c-- ) {
        return $c unless $m % $c or $n % $c;
    }
}

sub main {
    my $N   = shift;
    my $sum = 0;

    die "You must specify a value\n" unless $N;
    die "The value is not a positive integer > 1\n" if $N =~ /[^0-9]/ or $N < 2;

    for my $i ( 1 .. $N - 1 ) {
        for my $j ( $i + 1 .. $N ) {
            $sum += _gcd( $i, $j );
        }
    }

    say $sum;
}

main(@ARGV);

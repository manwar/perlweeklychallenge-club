#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use Carp;

my $inputs = [
    { N => 1, D => 2 },
    { N => 1, D => 3 },
    { N => 2, D => 3 },
    { N => 3, D => 16 },
    { N => 3, D => 4 },
    { N => 5, D => 66 },
];

for my $i ( $inputs->@* ) {
    my $out = decimal_string( $i->{N}, $i->{D} );
    say qq{Input:  \$N = $i->{N}, \$D = $i->{D}, };
    say qq{Output: $out};
    say '';
}

sub decimal_string ( $n, $d ) {
    croak 'Cannot Divide By Zero' if $d == 0;
    my $out = 0;
    my $x   = 1 / $d;
    my $r   = 1 % $d;
    my $nn  = $n * $x;
    my ( $integral, $mantissa ) = split /\./, $nn;
    my $length = length $mantissa;
    my $c      = 0;
OUTER: for my $i ( 0 .. $length ) {
        for my $j ( 1 .. $length ) {
            my $copy   = $mantissa;
            my $string = substr( $mantissa, $i, $j );
            next unless length $string > 0;
            next if $j > $length;
            if ( $mantissa =~ /^\d*$string$string/mix ) {
                substr( $copy, $i ) = qq{($string)};
                $nn = join '.', $integral, $copy;
                last OUTER;
            }
        }
    }
    return $nn;
}

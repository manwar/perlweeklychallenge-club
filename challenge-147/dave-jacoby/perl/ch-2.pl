#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

my $top      = 10_000;
my @pentagon = map { pentagon($_) } 0 .. $top;
my %pentagon = map { $_ => 1 } @pentagon;
delete $pentagon{0};

for my $i ( 1 .. $top ) {
    for my $j ( 1 .. $i  ) {
        my $pi  = $pentagon[$i];
        my $pj  = $pentagon[$j];
        my $sum = $pi + $pj;
        if ( $pentagon{$sum} ) {
            my $product = abs( $pi - $pj );
            if ( $pentagon{$product} ) {
                say <<"END";
        P($i) = $pi
        P($j) = $pj
        $pi + $pj = $sum
        abs( $pi - $pj ) = $product
END
                exit;
            }
        }
    }
}

sub pentagon ( $n ) {
    return $n * ( ( $n * 3 ) - 1 ) / 2;
}

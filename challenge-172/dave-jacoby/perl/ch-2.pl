#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ min max sum0 };

my @array = ( 0, 0, 1, 2, 63, 61, 27, 13 );

my @five = five_number_summary(@array);
say join ' ', @five;

sub five_number_summary ( @array ) {
    my $min    = min @array;
    my $max    = max @array;
    my $median = median(@array);
    my $lc     = median( grep { $_ < $median } @array );
    my $uc     = median( grep { $_ > $median } @array );
    return $min, $lc, $median, $uc, $max;
}

sub median ( @array ) {
    my @sorted = sort { $a <=> $b } @array;
    while ( scalar @sorted > 2 ) {
        shift @sorted;
        pop @sorted;
    }

    return ( sum0 @sorted ) / 2 if scalar @sorted > 1;
    return $sorted[0];
}

#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

my @examples = qw( 6 12 24 36 );

for my $i (@examples) {
    my $o = stealthy_numbers($i);
    say <<"END";
    Input:  \$n = $i
    Output: $o
END
}

sub stealthy_numbers ( $n ) {
    my @factors = get_factor_pairs($n);
    for my $i ( 0 .. -1 + scalar @factors ) {
        my ( $ix, $iy ) = $factors[$i]->@*;
        for my $j ( $i + 1 .. -1 + scalar @factors ) {
            my ( $jx, $jy ) = $factors[$j]->@*;
            my $addi = $ix + $iy;
            my $addj = $jx + $jy;
            return 1 if abs( $addi - $addj ) == 1;
        }
    }
    return 0;
}

sub get_factor_pairs( $n ) {
    my %hash;
    for my $x ( map { int $_ } 1 .. $n ) {
        next unless $n % $x == 0;
        my $y  = $n / $x;
        my $xy = join ',', sort { $a <=> $b } $x, $y;
        $hash{$xy} = 1;
    }
    return map { [ split /,/, $_ ] } sort keys %hash;
}

#!/usr/bin/env perl
use strict;
use warnings;
use v5.10;
use Data::Dumper;

my $sum = 12;
my @numbers = ( 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 );

my @even_numbers;
foreach (@numbers) { push(@even_numbers, $_) if $_ % 2 == 0; }

my @series;

while (my $even_n = shift @even_numbers) {
    foreach ( @numbers ) {
	    next if $sum - $even_n - $_ <= 0;
        push( @series, [$even_n, $_, $sum - $even_n - $_] );
    }
}

foreach ( @series ) {
    print join ', ', $_->[0], $_->[1], $_->[2];
    print "\n";
}




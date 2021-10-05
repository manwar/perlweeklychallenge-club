#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum sum0 };
my @from_wikipedia = ( 4, 22, 27, 58, 85, 95, 121 );
my %from = map { $_ => 1 } @from_wikipedia;

my @smith_numbers = get_smith_numbers();

say join ', ', @smith_numbers;

exit;

sub sum_of_digits ( $n ) { return sum split //, $n }

sub sum_of_factors ( $n ) {
    my %factors;
    my $output = 0;
    my $nn     = $n;
    for my $i ( 2 .. $n - 1 ) {
        if ( $nn % $i == 0 ) {
            while ( $nn % $i == 0 ) {
                $factors{$i}++;
                $nn /= $i;
            }
        }
    }
    $output += sum0 map { sum( split //, $_ ) * $factors{$_} } keys %factors;
    return $output || 0;
}

sub get_smith_numbers {
    my @output;
    my $i = 2;
    while ( scalar @output < 10 ) {
        my $d = sum_of_digits($i);
        my $f = sum_of_factors($i);
        my $e = $d == $f ? 1 : 0;
        push @output, $i if $e;
        exit if $i > 500;
        $i++;
    }
    return @output;
}

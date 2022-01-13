#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

my @num_divisors = get_number_divisors( 1, 10, 8 );

sub get_number_divisors ( $start, $count, $divisors ) {
    my @output;
    my $s = $start;
    while (1) {
        my @divisors;
        for my $i ( 1 .. $s ) {
            push @divisors, $i if $s % $i == 0;
        }
        if ( scalar @divisors == $divisors ) {
            say join " ", $s, ':', ( scalar @divisors ), ':', @divisors;
            push @output, $s;
        }
        last if $count == scalar @output;
        $s++;
    }
    return @output;
}


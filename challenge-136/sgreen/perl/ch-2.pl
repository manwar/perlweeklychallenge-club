#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util qw(sum0);

sub _find_sums {
    my $solutions = 0;
    my ( $remaining, $pool ) = @_;

    while ( my $number = pop @$pool ) {
        my $sum = sum0(@$pool);
        if ( $number == $remaining or $number + $sum == $remaining ) {
            ++$solutions;
        }
        elsif ( $number < $remaining ) {
            if ( $sum >= $remaining - $number ) {
                #$solutions += _find_sums( $remaining - $number, \@new_pool );
                $solutions += _find_sums( $remaining - $number, [@$pool] );
            }
        }
    }
    return $solutions;
}

sub main {
    my $n = shift;

    # Sanity check
    die "You must specify an integer\n"         unless defined $n;
    die "The value is not a positive integer\n" unless $n =~ /^[1-9][0-9]*$/;

    # Generate list of Fibonacci numbers <= $n
    my @numbers = ( 1, 2 );
    while ( $numbers[-2] + $numbers[-1] <= $n ) {
        push @numbers, $numbers[-2] + $numbers[-1];
    }

    say _find_sums( $n, \@numbers );
}

main(@ARGV);

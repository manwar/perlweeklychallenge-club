#!/usr/local/bin/perl

use strict;
use warnings;

my ( $m, $n ) = @ARGV;
die "Max number $m is must be an integer.\n" if $m =~ m/\D/;
die "Combination length $n is must be an integer.\n" if $n =~ m/\D/;

my @combinations = get_combinations( 1, $m, $n - 1 );
print join( "\n", @combinations ) . "\n";

sub get_combinations {
    my ( $min, $m, $n ) = @_;

    my @combinations = ();
    if ( $n ) {
        for my $i ( $min .. ( $m - 1 )) {
            for my $combo ( get_combinations( $i + 1, $m, $n - 1 ) ) {
                push( @combinations, $i . $combo );
            }
        }
    } else {
        @combinations = ( $min .. $m );
    }

    return @combinations;
}

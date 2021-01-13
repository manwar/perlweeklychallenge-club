#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util 'sum';

sub main {
    my ( $A, $B ) = @_;

    # Sanity check
    die "You must enter two positive numbers\n" unless $A and $B;
    die "The first value is not a postive integer" unless $A =~ /^[1-9][0-9]*$/;
    die "The second value is not a postive integer"
      unless $B =~ /^[1-9][0-9]*$/;
    my $format = sprintf '%%s %%%dd × %%%dd', length($A), length( $A * $B );

    # Divide the first number (ignoring remainder), multiple second
    #  until $A = 1.
    my @table = ( [ $A, $B ] );
    while ( $A > 1 ) {
        $A = int( $A / 2 );
        $B *= 2;
        push @table, [ $A, $B ];
    }

    # Display the table
    my @addition = ();
    foreach my $row (@table) {
        # If the first number is odd, add it to the list
        my $odd = $row->[0] % 2;
        say sprintf $format, ( $odd ? '>' : ' ' ), @$row;
        push @addition, $row->[1] if $odd;
    }

    say "\nResult is: ", join( ' + ', @addition ), ' = ', sum(@addition);
}

main(@ARGV);


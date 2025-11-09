#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics 'variations_with_repetition';
use List::Util 'mesh';

sub main ( $input_string, $target ) {
    # Check the input string is only parentheses
    if ( $input_string !~ /^[0-9]+$/ ) {
        die "Input string must contain only digits\n";
    }
    my @input_digits = split //, $input_string;

    # Possible operators to insert between digits
    my @operators = ( '', '+', '-', '*' );

    my @magic_expressions = ();

    my $iter =
      variations_with_repetition( \@operators, length($input_string) - 1 );
    while ( my $ops = $iter->next ) {
        my $expression = join( "", mesh( \@input_digits, [@$ops, ''] ) );

        if ( $expression =~ /[\+\-\*]0\d/ ) {
            # Skip expressions with leading zeros
            next;
        }
        if ( eval($expression) == $target ) {
            push @magic_expressions, $expression;
        }
    }

    if ( $#magic_expressions == -1 ) {
        say "No expressions found";
    }
    else {
        say '("' . join( '", "', @magic_expressions ) . '")';
    }
}

main( $ARGV[0], $ARGV[1] );

#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub _in ( $s, $t ) {
    return index( $t, $s ) != -1;
}

sub print_row ( $line, $numbers ) {
    my @row = ();

    foreach my $n (@$numbers) {
        if ( ref($line) ) {
            # We have a left side and right side
            my $left  = _in( $line->[0], $n ) ? '|' : ' ';
            my $right = _in( $line->[1], $n ) ? '|' : ' ';
            push @row, "$left     $right";
        }
        else {
            # We want to show a solid line
            if ( _in( $line, $n ) ) {
                push @row, '-------';
            }
            else {
                push @row, '       ';
            }
        }
    }

    say join '  ', @row;
}

sub main ($n) {
    # Turn the numbers into a list of strings to show
    my @truth   = qw'abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg';
    my @numbers = map { $truth[$_] } split //, $n;

    # Define the lines we want to show
    my @lines = (
        'a',
        [ 'f', 'b' ],
        [ 'f', 'b' ],
        'g',
        [ 'e', 'c' ],
        [ 'e', 'c' ],
        'd'
    );

    foreach my $line (@lines) {
        print_row( $line, \@numbers );
    }
}

main( $ARGV[0] )
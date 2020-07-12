#!/usr/bin/perl

use strict;
use warnings;
use 5.10.1;

sub _ask_input ($$) {
    my ( $m, $n ) = @_;
    die "\$M is not a postive number" unless $m >= 1;
    die "\$N is not a postive number" unless $n >= 1;
    my @rows = ();

  ROW: for my $row ( 1 .. $m ) {
        while (1) {
            print "Enter values for row $row: ";
            my $input = <STDIN>;

            # Strip out everything that isn't a 0 or 1
            $input =~ s/[^01]//g;
            if ( length($input) != $n ) {
                say "You must enter $n values. Please try again.";
            }
            else {
                push @rows, [ split //, $input ];
                next ROW;
            }
        }
    }

    return @rows;
}

sub main (@) {
    my ( $M, $N ) = @_;

    # Get the data from the user input
    my @array = _ask_input( $M, $N );

    # Determine which rows and columns have negative values
    my @negative_cols = ();
    my @negative_rows = ();
    for my $r ( 0 .. $M - 1 ) {
        for my $c ( 0 .. $N - 1 ) {
            if ( $array[$r][$c] == 0 ) {
                $negative_rows[$r] = 1;
                $negative_cols[$c] = 1;
            }
        }
    }

    # Output the results
    for my $r ( 0 .. $M - 1 ) {
        my @row = ();
        for my $c ( 0 .. $N - 1 ) {
            push @row,
              (       $array[$r][$c]
                  and not $negative_rows[$r]
                  and not $negative_cols[$c] ) ? 1 : 0;
        }
        say '[ ' . join( ', ', @row ), ' ]';
    }
}

main(@ARGV);

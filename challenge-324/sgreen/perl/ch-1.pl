#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    my $cols = pop @ints;
    my $rows = pop @ints;
    if ( $rows < 1 or $cols < 1 ) {
        die "Rows and columns must be greater than 0.\n";
    }
    if ( @ints != $rows * $cols ) {
        die
          "The product of rows and columns must equal the length of the input list.\n";

    }
    my @result = ();
    foreach my $row ( 0 .. $rows - 1 ) {
        my @row = ();
        foreach my $col ( 0 .. $cols - 1 ) {
            push @row, shift @ints;
        }
        push @result, \@row;
    }

    say "(" . join( ", ", map { '[' . join( ", ", @$_ ) . ']' } @result ) . ")";
}

main(@ARGV);

#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _process_input {
    my @rows  = @_;
    my @cells = ();

    # Convert rows of x and * to an array of arrays
    foreach my $row (<>) {

        # Skip empty rows
        next if $row =~ /^\s+$/;
        push @cells, [ $row =~ /([x\*])/gm ];
    }

    # Check we have at least one row
    die "You must specify at least one row\n" unless scalar(@cells);

    # Check all rows are the same length
    foreach my $i ( 1 .. $#cells ) {
        die "Not all rows are the same length\n" if scalar( @{ $cells[0] } ) != scalar( @{ $cells[$i] } );
    }

    return @cells;
}

sub main {
    # Unlike most tasks, we will read the input from STDIN.
    my @cells = _process_input();

    # All movements, clockwise from up left
    my @directions = ( [ -1, -1 ], [ 0, -1 ], [ 1, -1 ], [ 1, 0 ], [ 1, 1 ], [ 0, 1 ], [ -1, 1 ], [ -1, 0 ] );

    my $rows = $#cells;
    my $cols = $#{ $cells[0] };

    # Inspect each cells
    foreach my $row ( 0 .. $rows ) {
        foreach my $col ( 0 .. $cols ) {
            # Skip cells that have mines
            next if $cells[$row][$col] eq 'x';

            # Count the number of surronding mines if the are within the
            #  bounds of the board
            my $mines = 0;
            foreach my $delta (@directions) {
                my $x = $row + $delta->[0];
                my $y = $col + $delta->[1];
                ++$mines if $x >= 0 and $x <= $rows and $y >= 0 and $y <= $cols and $cells[$x][$y] eq 'x';
            }
            $cells[$row][$col] = $mines;
        }
    }

    # Display the results
    foreach my $rows (@cells) {
        say join ' ', @$rows;
    }
}

main();

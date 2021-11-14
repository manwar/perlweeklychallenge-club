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
        push @cells, [ $row =~ /([01])/gm ];
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

    my $rows       = $#cells;
    my $cols       = $#{ $cells[0] };
    my $best_width = my $best_height = 0;

    # Inspect each cell as the top left of the inner matrix
    foreach my $y ( 0 .. $rows ) {
        foreach my $x ( 0 .. $cols ) {
            # Skip cells that have a one
            next if $cells[$y][$x] == 1;

            my $max_width = $cols - $x;

            foreach my $height ( 0 .. $rows - $y ) {
                last if $cells[ $y + $height ][$x] == 1;

                my $width = 0;
                foreach my $this_width ( 1 .. $max_width ) {
                    last if $cells[ $y + $height ][ $x + $this_width ] == '1';
                    $max_width = $this_width;
                    ++$width;
                }

                # This is matrix bigger than what we've already found
                if ( ( $best_width * $best_height ) < ( ( $width + 1 ) * ( $height + 1 ) ) ) {
                    $best_width  = $width + 1;
                    $best_height = $height + 1;
                }
            }
        }
    }

    # Display the result
    my $row = '[ ' . ( '0 ' x $best_width ) . ']';
    say $row foreach ( 1 .. $best_height );

}

main();

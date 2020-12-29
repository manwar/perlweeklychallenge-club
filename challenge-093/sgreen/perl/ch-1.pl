#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util 'max';

sub main {
    my @numbers = ( join( ' ', @_ ) =~ /(\d+)/g );

    # Sanity check
    die "You must provide me some numbers\n" unless @numbers;
    die "You must provide an even amount of numbers\n" if @numbers % 2;

    # Plot all the points on the grid, (0,0) is bottom right.
    my @grid = ();
    for ( my $i = 0 ; $i < $#numbers ; $i += 2 ) {
        $grid[ $numbers[$i] - 1 ][ $numbers[ $i + 1 ] - 1 ] = 1;
    }

    # Get the bounds of the grid
    my $max_y = $#grid;
    my $max_x = max( map { scalar( @{ $_ // [] } ) } @grid );

    # Although not part of the task, lets draw a grid
    foreach my $row ( reverse @grid ) {
        $row //= [];
        say join ' ', '|', map { $_ ? 'x' : ' ' } @$row;
    }
    say '+', ' -' x $max_x;

    my $max        = 0;
    my @directions = (
        [ 1,  0 ],    # Right
        [ 0,  1 ],    # Up
        [ 1,  1 ],    # Diagonally up and right
        [ -1, 1 ],    # Diagionally up and left
    );

    # Now work through each point, in each direction
    foreach my $x ( 0 .. $max_x ) {
        foreach my $y ( 0 .. $max_y ) {
            # A line can't start here if the value is not true
            next unless $grid[$x][$y];

            foreach my $direction (@directions) {
                my ( $delta_x, $delta_y ) = @$direction;

                my $count = 0;
                while ( ++$count ) {
                    # Exit the loop when we've found a non true value or have reached the bottom of the grid.
                    last
                      unless $grid[ $x + $delta_x * $count ][ $y + $delta_y * $count ]
                      and $x + $delta_x * $count >= 0;
                }

                $max = $count if $max < $count;
            }
        }
    }

    say "\nOutput is: $max";
}

main(@ARGV);

#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'max';

sub _get_tightest_grid {
    my $count = shift;
    my $max_x = $count;
    my $max_y = 1;

    for my $y ( 2 .. $count - 1 ) {
        my $x = $count / $y;
        if ( $count % $y == 0 and abs( $x - $y ) < abs( $max_x - $max_y ) ) {
            # We have found a tighter solution
            ( $max_x, $max_y ) = ( $x, $y );
        }
    }

    return ( $max_x, $max_y );

}

sub main {
    my @values = @_;
    die "You must specify at least one value\n" unless scalar(@values);

    # Work out the tightest grid. This is when the x + y values are the least
    my ( $max_x, $max_y ) = _get_tightest_grid( scalar(@values) );

    # The directions we can move (right, up, left, down)
    my @directions = ( [ 1, 0 ], [ 0, 1 ], [ -1, 0 ], [ 0, -1 ] );

    # Populate the grid
    my @grid = ();
    my $x    = my $y = my $direction = 0;    # Bottom left, going rightward
    foreach my $i ( 0 .. $#values ) {
        $grid[$y][$x] = $values[$i];

        # Determine the next position
        my $next_x = $x + $directions[$direction][0];
        my $next_y = $y + $directions[$direction][1];

        # We need to switch directions if we are out of bounds or the cell already has a value
        if (   $next_x >= $max_x
            or $next_y >= $max_y
            or $next_x == -1
            or $next_y == -1
            or defined( $grid[$next_y][$next_x] ) )
        {
            $direction = ++$direction % 4;
        }

        # Move to the next cell
        $x += $directions[$direction][0];
        $y += $directions[$direction][1];
    }

    # Display the output. Right aligned for all numbers, else left aligned
    my $max_length   = max( map { length($_) } @values );
    my $all_integers = grep { /^\d+$/ } @values;
    my $format       = $all_integers ? "\%${max_length}d" : "\%-${max_length}s";
    foreach my $row ( reverse @grid ) {
        say join ' ', map { sprintf $format, $_ } @$row;
    }
}

main(@ARGV);

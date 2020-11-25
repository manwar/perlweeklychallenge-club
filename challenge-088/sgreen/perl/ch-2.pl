#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my @array = ();

    # Process the input
    foreach (@_) {
        push @array, [/(\d+)/g];
    }

    # Sanity check
    foreach my $row ( 1 .. $#array ) {
        die "Each row must have the same number of colums\n"
          if scalar( @{ $array[0] } ) != scalar( @{ $array[$row] } );
    }

    my $rows = scalar(@array);
    my $cols = scalar( @{ $array[0] } );

    # Right, down, left and up
    my @directions = ( [ 0, 1 ], [ 1, 0 ], [ 0, -1 ], [ -1, 0 ] );

    # Map out the values we've used
    my @used = ( map { [ (0) x $cols ] } ( 1 .. $rows ) );

    # We start at the top left, moving right
    my $x         = 0;
    my $y         = 0;
    my $direction = 0;
    my @solutions = ();

    # Loop until we've found all the numbers
    while ( scalar(@solutions) < $rows * $cols ) {
        push @solutions, $array[$x][$y];
        $used[$x][$y] = 1;

        my $next_x = $x + $directions[$direction][0];
        my $next_y = $y + $directions[$direction][1];

        # If we've reached the bounds of our grid, or found a value
        #  we've already used, we need to switch direction
        if (   $next_x == $cols
            or $next_y == $rows
            or $next_x < 0
            or $next_y < 0
            or $used[$next_x][$next_y] )
        {
            $direction = ++$direction % 4;
            $next_x    = $x + $directions[$direction][0];
            $next_y    = $y + $directions[$direction][1];
        }

        $x = $next_x;
        $y = $next_y;
    }

    say join ', ', @solutions;
}

main(@ARGV);

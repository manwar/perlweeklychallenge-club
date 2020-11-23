#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util qw(min);

sub _count_ones {
    # Count the number of sequencial ones in the row. There might be a
    #  better way, but at least this works™
    my $count = 0;
    ++$count while $_[$count];
    return $count;
}

sub main {
    my @array = ();

    # Process the input
    foreach my $row (@_) {
        $row =~ s/[^01]//g;
        die "Each row must have at least two '0' or '1'\n" if length($row) < 2;
        push @array, [ split //, $row ];
    }

    # Sanity check
    die "You must specify at least two rows\n" if scalar(@array) < 2;
    foreach my $row ( 1 .. $#array ) {
        die "Each row must have the same number of colums\n"
          if scalar( @{ $array[0] } ) != scalar( @{ $array[$row] } );
    }

    my $rows = scalar(@array);
    my $cols = scalar( @{ $array[0] } );

    my $max_width  = 0;
    my $max_height = 0;

    # Go through each rows and column
    # The top left of a square cannot be on the right or bottom row (hence -2)
    my @squares = ();
    foreach my $row ( 0 .. $rows - 2 ) {
        foreach my $col ( 0 .. $cols - 2 ) {
            my $this_width =
              _count_ones( @{ $array[$row] }[ $col .. $cols - 1 ] );

            # No rectangle if this row has < 2 zeros
            next if $this_width < 2;

            # Find the maximum rectangle size
            for my $this_height ( 2 .. $rows - $row ) {
                $this_width = min(
                    $this_width,
                    _count_ones(
                        @{ $array[ $row + $this_height - 1 ] }
                          [ $col .. $cols - 1 ]
                    )
                );

                # No more rectangles can be made from this starting point
                last if $this_width < 2;

                # Update the largest rectangle if this one is bigger
                if ( $this_width * $this_height > $max_width * $max_height ) {
                    $max_width  = $this_width;
                    $max_height = $this_height;
                }
            }
        }
    }

    # Display the output
    if ($max_width) {
        for ( 1 .. $max_height ) {
            say '[ ', ( '1 ' x $max_width ), ']';
        }
    }
    else {
        say 'Output: 0';
    }
}

main(@ARGV);

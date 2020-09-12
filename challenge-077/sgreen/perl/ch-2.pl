#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main (@) {
    my @array  = ();
    my @lonely = ();

    # Process the input
    foreach my $row (@_) {
        $row =~ s/[^OX]//g;
        die "Each row must have at least one 'O' or 'X'\n" if $row eq '';
        push @array, [ split '', $row ];
    }

    # Sanity check
    die "You must specify at least one row\n" if scalar(@array) == 0;
    foreach my $row ( 1 .. $#array ) {
        die "Each row must have the same number of colums\n"
          if scalar( @{ $array[0] } ) != scalar( @{ $array[1] } );
    }

    my $rows = scalar(@array);
    my $cols = scalar( @{ $array[0] } );
    # Go through each row and column
    foreach my $row ( 0 .. $rows - 1 ) {
      COL: foreach my $col ( 0 .. $cols - 1 ) {
            # Skip if the value is 'O'
            next if $array[$row][$col] eq 'O';

            foreach my $r ( -1, 0, 1 ) {
                foreach my $c ( -1, 0, 1 ) {
                    # We don't check my own value, nor if we are out of bounds
                    next
                      if ( $r == 0 and $c == 0 )
                      or $row + $r < 0
                      or $row + $r >= $rows
                      or $col + $c < 0
                      or $col + $c >= $cols;

                    # We can end the check if the value of the surrounding
                    # cell is 'X'
                    next COL if $array[ $row + $r ][ $col + $c ] eq 'X';
                }
            }

            # I'm a lonely value
            push @lonely, sprintf 'row %d col %d', $row + 1, $col + 1;
        }
    }

    say 'Output is ', scalar(@lonely);
    say 'Matches: ', join( ', ', @lonely ) if scalar @lonely;
}

main(@ARGV);


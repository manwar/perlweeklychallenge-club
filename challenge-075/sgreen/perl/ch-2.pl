#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(min max);
use 5.10.1;

sub _format_val {
    # Return something like "row 1" or "rows 1 - 3"
    my ( $type, $low, $high ) = @_;
    return $low == $high ? "$type $low" : "${type}s $low - $high";
}

sub main {
    my @array = @_;

    # Sanity check
    die "You must enter at least one value" if $#array == -1;

    foreach my $value (@array) {
        die "Value '$value' is not an integer\n"
          unless $value =~ /^[1-9][0-9]*$/;
    }

    # This stores the results
    my $maximum   = 0;
    my @rows      = ();
    my $max_value = max @array;

    # Let's calculate the largest histogram rectangle
    for my $left ( 0 .. $#array ) {
        for my $right ( $left .. $#array ) {
            # Find the minimum value from the rows, and therefore the
            #  size of the rectangle
            my $min  = min( @array[ $left .. $right ] );
            my $rect = ( $right - $left + 1 ) * $min;
            if ( $rect >= $maximum ) {
                if ( $rect > $maximum ) {
                    $maximum = $rect;
                    @rows    = ();
                }
                push @rows,
                  _format_val( 'row', $left + 1, $right + 1 ) . ' '
                  . _format_val( 'col', 1, $min );
            }
        }
    }

    # Display the result
    say "Largest rectangle histogram is $maximum (", join( '; ', @rows ), ')';
    say '';

    # BONUS POINTS: Display the histogram
    my $width = length($max_value);
    my $empty = ' ' x ($width);
    my $fill  = '#' . ( ' ' x ( $width - 1 ) );

    for ( my $i = $max_value ; $i > 0 ; $i-- ) {
        say join ' ',
          sprintf( "\%${width}d", $i ),
          map { $_ >= $i ? $fill : $empty } @array;
    }

    # The dashes row
    say join ' ', ( '-' x $width ) x ( $#array + 2 );

    # And finally the counts for each array
    say join ' ', ( ' ' x $width ), map { sprintf "\%-${width}s", $_ } @array;

}

main(@ARGV);

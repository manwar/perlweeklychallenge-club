#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw(min max);
use 5.10.1;

sub _display_histogram {
    my ( $array, $fills ) = @_;

    my $max_value = max @$array;

    # Build an array of arrays with the height of the block, and the
    # height of the fill line
    my @columns =
      map { [ $array->[$_], $array->[$_] + $fills->[$_] ] } ( 0 .. $#$array );

    my $width = length($max_value);
    my $empty = ' ' x ($width);
    my $fill  = '·' . ( ' ' x ( $width - 1 ) );
    my $block = '#' . ( ' ' x ( $width - 1 ) );

    for ( my $i = $max_value ; $i > 0 ; $i-- ) {
        say join ' ', sprintf( "\%${width}d", $i ),
          map { $_->[0] >= $i ? $block : $_->[1] >= $i ? $fill : $empty }
          @columns;
    }

    # The dashes row
    say join ' ', ( '-' x $width ) x ( $#$array + 2 );

    # And finally the counts for each array
    say join ' ', ( ' ' x $width ), map { sprintf "\%-${width}s", $_ } @$array;
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
    my @fills = (0);    # The first column cannot hold water
    my $drops = 0;

    # Let's calculate the storage capcity for each column
    # (except first and last)
    foreach my $col ( 1 .. $#array - 1 ) {
        my $height = $array[$col];

        # The maximum height to the left and to the right
        my $left  = max map { $array[$_] } ( 0 .. $col - 1 );
        my $right = max map { $array[$_] } ( $col + 1 .. $#array );

        # We can fill to the minimum of left and right, minus the
        # height of this column
        my $x = min( $left, $right ) - $height;
        $x = 0 if $x < 0;

        $drops += $x;
        push @fills, $x;
    }

    # The last column cannot hold water
    push @fills, 0;

    # Display the history
    _display_histogram( \@array, \@fills );

    say "\nResult is $drops";
}

main(@ARGV);

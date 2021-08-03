#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

# These constants makes it easier to explain
use constant X1 => 0;
use constant Y1 => 1;
use constant X2 => 2;
use constant Y2 => 3;
use constant X3 => 4;
use constant Y3 => 5;
use constant X4 => 6;
use constant Y4 => 7;

sub _distance_between {
    # Work out the distance between two points
    my ( $x1, $y1, $x2, $y2 ) = @_;
    my $delta_x = abs( $x1 - $x2 );
    my $delta_y = abs( $y1 - $y2 );
    return sqrt( $delta_x**2 + $delta_y**2 );
}

sub _is_square {
    my @values = @_;

    # Get the distance between the first two points
    my $delta = _distance_between( @values[ X1, Y1, X2, Y2 ] );

    # Make sure each side is of equal length
    return 0 if _distance_between( @values[ X2, Y2, X3, Y3 ] ) != $delta;
    return 0 if _distance_between( @values[ X3, Y3, X4, Y4 ] ) != $delta;
    return 0 if _distance_between( @values[ X4, Y4, X1, Y1 ] ) != $delta;

    # Make sure the two cross angles are also of the same length
    return 0 if _distance_between( @values[ X1, Y1, X3, Y3 ] ) != _distance_between( @values[ X2, Y2, X4, Y4 ] );

    # It's a square
    return 1;
}

sub main {
    my @values = @_;

    # Sanity check
    die "You must provide eight numbers\n" unless scalar(@values) == 8;
    foreach my $x (@values) {
        die "The value '$x does not appear to be a number\n" unless $x =~ /^-?[0-9]+(?:\.[1-9]+)?$/;
    }

    say _is_square(@values);
}

main(@ARGV);

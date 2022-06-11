#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util qw(min max);

package Rectangle;

sub new {
    my ( $class, $x1, $y1, $x2, $y2 ) = @_;
    # Ensure x1 is the left side
    if ( $x1 > $x2 ) {
        ( $x1, $x2 ) = ( $x2, $x1 );
    }
    # Ensure y1 is the bottom side
    if ( $y1 > $y2 ) {
        ( $y1, $y2 ) = ( $y2, $y1 );
    }

    my $self = {
        x1 => $x1,
        x2 => $x2,
        y1 => $y1,
        y2 => $y2,
    };

    bless $self, $class;
    return $self;
}

sub area {
    my $self = shift;

    # Return the area of the rectangle
    return ( $self->{x2} - $self->{x1} ) * ( $self->{y2} - $self->{y1} );
}

package main;

sub main {
    my $s       = shift;
    my @numbers = ( $s =~ m/(-?\d+)/g );

    # Find out the combined area of the two rectangles
    my $rect1 = Rectangle->new( @numbers[ 0 .. 3 ] );
    my $rect2 = Rectangle->new( @numbers[ 4 .. 7 ] );
    my $area  = $rect1->area + $rect2->area;

    # Calculate any overlap
    my $dx1 = max( $rect1->{x1}, $rect2->{x1} );
    my $dy1 = max( $rect1->{y1}, $rect2->{y1} );
    my $dx2 = min( $rect1->{x2}, $rect2->{x2} );
    my $dy2 = min( $rect1->{y2}, $rect2->{y2} );

    # If there is, remove that from the calculations
    if ( $dx1 < $dx2 and $dy1 < $dy2 ) {
        my $d = Rectangle->new( $dx1, $dy1, $dx2, $dy2 );
        $area -= $d->area();
    }

    say $area;
}

main(@ARGV);
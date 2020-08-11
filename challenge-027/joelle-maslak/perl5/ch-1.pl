#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;
use utf8;    # For unicode comments

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

# This program finds the intersection of two lines.  While the word
# "ends" is used, I'm instead assuming that these are true mathematical
# lines, not line segments, so the intersection point may not be between
# the two points that define the line.
#
# The first thing we need to do is to find the slope of each line.
#
# Edge case 1: If either line is not fully defined, we return an error.
# This happens if both points are the same.
#
# Edge case 2: A vertical line can't be defined by the standard y = A × x₁ + C
# equation.  In this case we handle it differently, see below.  We use ∞
# (undef) for the slope in this case.
#
# To find the slope (of non-vertical lines), it's just rise / run, which is
# easy to calculate.  For the constant, we need to solve this:
#  y = Ax + C
# A given point will define x and y, while the slope defines A, so we just
# solve for C.  THus:
#  C = y - Ax;
#
# If we have two equations: y₁ = A₁ × x₁ + C₁
#                           y₂ = A₂ × x₂ + C₂
#
# We can find the intersection:
#   1) If slope is identical, and constants differ, NO INTERSECTION
#   2) If slope is identical, and constants are the same, this is the
#      same line.
#   3) If the slope is infinite of either line, just solve the other
#      equation to determine y for that value of x.
#   4) Otherwise, we're looking for the point where x₁=x₂ and y₁=y₂
#      Thus, we can rewrite the equations as:
#       y = A₁ × x + C₁
#       y = A₂ × x + C₂
#      We can solve this system for x:
#       A₁ × x + C₁ = A₂ × x + C₂
#      Rewritten:
#       A₁ × x - A₂ × x = C₂ - C₁
#      Rewritten:
#       (A₁ - A₂) × x = C₂ - C₁
#       x = (C₂ - C₁) ÷ (A₁ - A₂)
#      Once we have x, we can solve for y by plugging into either of the
#      original equations.
#

package Point {
    use Moose;
    use feature 'signatures';
    no warnings 'experimental::signatures';

    use Regexp::Common;

    has x => (
        is       => 'rw',
        isa      => 'Num',
        required => 1,
    );

    has y => (
        is       => 'rw',
        isa      => 'Num',
        required => 1,
    );

    sub from_string ( $self, $point_str ) {
        $point_str =~ s/^ \( [.*] \) $/$1/sx;    # Remove parens

        my (@parts) = split ',', $point_str;
        if ( scalar( grep { /^ $RE{num}{real} $/sx } @parts ) != scalar(@parts) ) {
            die("Invalid point specification");
        }
        die("Invalid point specification") unless scalar(@parts) == 2;

        return $self->new( x => $parts[0], y => $parts[1] );
    }

    sub eqv ( $self, $point ) {
        return ( ( $self->x == $point->x ) && ( $self->y == $point->y ) );
    }
}

package Line {
    use Moose;
    use feature 'signatures';
    no warnings 'experimental::signatures';

    has slope => (
        is       => 'rw',
        isa      => 'Maybe[Num]',
        required => 1,
    );

    has point => (
        is       => 'rw',
        isa      => 'Point',
        required => 1,
    );

    sub solve_for_x ( $self, $y ) {
        # Vertical line exception
        return $self->x if !defined $self->slope;

        # Horizontal line exception
        if ( $self->slope == 0 ) {
            die "Cannot solve for $y" if $self->point->y != $y;
        }

        return ( $y - $self->y_offset ) / $self->slope;
    }

    sub solve_for_y ( $self, $x ) {
        # Horizontal line exception
        return $self->point->y if $self->slope == 0;

        # Vertical line exception
        if ( !defined $self->slope ) {
            die "Cannot solve for $x" if $self->point->x != $x;
        }

        # Lines between horizontal and vertical
        return $self->slope * $x + $self->y_offset;
    }

    sub y_offset($self) {
        # Vertical line exception
        return if !defined $self->slope;

        # Non-vertical lines
        return $self->point->y - $self->slope * $self->point->x;
    }

    sub intersection ( $self, $line ) {
        die "Lines are the same" if $self->eqv($line);
        if ( defined $self->slope and defined $line->slope ) {
            die "Lines do not intersect" if $self->slope == $line->slope;
        }

        # If either line is vertical
        if ( !defined $self->slope ) {
            return Point->new( x => $self->point->x, y => $line->solve_for_y( $self->point->x ) );
        } elsif ( !defined $line->slope ) {
            return Point->new( x => $line->point->x, y => $self->solve_for_y( $line->point->x ) );
        }

        # We're finding a normal intersection
        my $x = ( $line->y_offset - $self->y_offset ) / ( $self->slope - $line->slope );
        my $y = $self->solve_for_y($x);

        return Point->new( x => $x, y => $y );
    }

    sub eqv ( $self, $line ) {
        # Are both vertical?
        if ( ( !defined $self->slope ) and ( !defined $line->slope ) ) {
            return $self->point->x == $line->point->x;
        }

        # Only one is vertical
        return if ( !defined $self->slope ) or ( !defined $line->slope );

        # All other lines
        return if $self->slope != $line->slope;
        return ( $self->point->y == $line->solve_for_y( $self->point->x ) );
    }

    sub from_points ( $self, $point1, $point2 ) {
        # Handle same point
        die "Lines must be defined with two different points" if $point1->eqv($point2);

        # Handle vertical line exception
        return $self->new( point => $point1, slope => undef ) if $point1->x == $point2->x;

        # Handle other lines.
        my $slope = ( $point1->y - $point2->y ) / ( $point1->x - $point2->x );
        return $self->new( point => $point1, slope => $slope );
    }
}

# point1 and point2 define a line.  You can determine which line by the
# letter
sub MAIN ( $point1a, $point2a, $point1b, $point2b ) {
    my $line1 = Line->from_points( Point->from_string($point1a), Point->from_string($point2a), );
    my $line2 = Line->from_points( Point->from_string($point1b), Point->from_string($point2b), );

    if ( $line1->eqv($line2) ) {
        say "The two lines are the same";
    } elsif ( ( !defined $line1->slope ) and ( !defined $line2->slope ) ) {
        say "The two lines don't intersect";
    } elsif ( defined $line1->slope and defined $line2->slope and $line1->slope == $line2->slope ) {
        say "The two lines don't intersect";
    } else {
        my $intersection = $line1->intersection($line2);
        say "The lines intersect at (" . $intersection->x . "," . $intersection->y . ")";
    }

    return;
}

MAIN(@ARGV);


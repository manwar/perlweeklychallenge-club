#!/usr/bin/env perl6
use v6;

use StrictClass;

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
# for the slope in this case.
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

class Point does StrictClass {
    has Real:D $.x is rw is required;
    has Real:D $.y is rw is required;

    method from-string(Str:D $point-str is copy -->Point:D) {
        $point-str ~~ s:s/^ '(' [.*] ')' $/$0/;  # Remove parens
        my (Real:D $x, Real:D $y) = $point-str.split(',').map( +* );

        return Point.new(:$x, :$y);

        CATCH {
            # We must have been passed a bad point
            die "$point-str is an invalid point definition";
        }
    }
}

class Line does StrictClass {
    has Real:D  $.slope is rw is required;
    has Point:D $.point is rw is required;  # Any valid point on the line

    method solve-for-x(Real:D $y -->Real:D) {
        # Vertical line exception
        return $.point.x if $.slope == ∞;

        # Horizontal line exception
        if $.slope == 0 {
            die "Cannot solve for $y" if $.point.y ≠ $y;
        }

        return ($y - self.y-offset) ÷ $.slope;
    }

    method solve-for-y(Real:D $x -->Real:D) {
        # Horizontal line exception
        return $.point.y if $.slope == 0;

        # Vertical line exception
        if $.slope == ∞ {
            die "Cannot solve for $x" if $.point.x ≠ $x;
        }

        # Lines between horizontal and vertical
        return $.slope × $x + self.y-offset;
    }

    method y-offset(-->Real:D) {
        # Vertical line exception
        return ∞ if $.slope == ∞;

        # Non-vertical lines
        return $.point.y - $.slope × $.point.x;
    }

    method intersection(Line:D $line -->Point:D) {
        die "Lines are the same" if self eqv $line;
        die "Lines do not intersect" if self.slope == $line.slope;

        # If either line is vertical
        if self.slope == ∞ {
            return Point.new(:x(self.point.x),  :y($line.solve-for-y(self.point.x)));
        } elsif $line.slope == ∞ {
            return Point.new(:x($line.point.x), :y(self.solve-for-y($line.point.x)));
        }

        # We're finding a normal intersection
        my $x = ($line.y-offset - self.y-offset) ÷ (self.slope - $line.slope);
        my $y = self.solve-for-y($x);

        return Point.new(:$x, :$y);
    }

    # We need an eqv that works
    CORE::<&infix:<eqv>>.add_dispatchee(
        multi sub infix:<eqv> (Line:D $line1, Line:D $line2 -->Bool) {
            return False if $line1.slope ≠ $line2.slope;

            # Are both vertical?
            if $line1.slope == ∞ and $line2.slope == ∞ {
                return $line1.point.x == $line2.point.x;
            }

            # All other lines
            return $line1.point.y == $line2.solve-for-y($line1.point.x);
        }
    );

    method from-points(Point:D $point1, Point:D $point2 -->Line:D) {
        # Handle same point
        die "Lines must be defined with two different points" if $point1 eqv $point2;

        # Handle vertical line exception
        return Line.new(:point($point1), :slope(∞)) if $point1.x == $point2.x;

        # Handle other lines.
        my $slope = ($point1.y - $point2.y) ÷ ($point1.x - $point2.x);
        return Line.new(:point($point1), :$slope);
    }
}

# point1 and point2 define a line.  You can determine which line by the
# letter
sub MAIN(Str:D $point1a, Str:D $point2a, Str:D $point1b, $point2b) {
    my $line1 = Line.from-points(
        Point.from-string($point1a),
        Point.from-string($point2a),
    );
    my $line2 = Line.from-points(
        Point.from-string($point1b),
        Point.from-string($point2b),
    );

    if $line1 eqv $line2 {
        say "The two lines are the same";
    } elsif $line1.slope == $line2.slope {
        say "The two lines don't intersect";
    } else {
        my $intersection = $line1.intersection($line2);
        say "The lines intersect at ({ $intersection.x },{ $intersection.y })";
    }

    return;
}


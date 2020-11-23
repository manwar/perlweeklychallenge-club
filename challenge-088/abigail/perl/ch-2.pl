#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Challenge
#
# You are given m x n matrix of positive integers.
# 
# Write a script to print spiral matrix as list.
# 

#
# We solve this by keeping track of the boundaries (min_x, min_y, max_x,
# max_y) of the part of the matrix which still needs to be processed.
# Initially, min_x and min_y are 0, max_x is the index of the bottom row,
# and max_y is the index of the right most column. The boundaries are
# stored in an array @boundaries, using indices $MIN_X, $MIN_Y, $MAX_X,
# $MAX_Y.
#
# We also keep track of the current position, that is, the position
# of the value which should be printed next. This starts off as (0, 0),
# the index of the top left corner.
#
# Next thing we keep track of is the direction of travel, the change in
# (x, y) coordinate we take at each step. This will be initialized as
# (0, 1), as we start off moving to the right.
#
# We now move through the matrix in the direction of travel, printing
# the current value. If we hit the end of the yet-to-be-printed matrix,
# we rotate the direction of movement by 90 degrees, and update one of
# the boundaries:
#   - If we have travelled the top row,      we increment $min_x;
#   - If we have travelled the right column, we decrement $max_y;
#   - If we have travelled the bottom row,   we decrement $max_x;
#   - If we have travelled the left column,  we increment $min_y.
#
# Note that we always travel the edges in the same order:
# top row (left to right), right edge (top to bottom),
# bottom row (right to left), left edge (bottom to top), and then repeat.
#
# We stop if $min_x > $max_x, or $min_y > $max_y.
#

my @matrix = map {[/[1-9][0-9]*/g]} <>;

#
# Check whether all lines are the same size
#
die "Not a matrix" if grep {@$_ != @{$matrix [0]}} @matrix;

#
# Boundaries
#
my @boundaries;
   $boundaries [my $MIN_X = 0] = 0;
   $boundaries [my $MAX_Y = 1] = $#{$matrix [0]};
   $boundaries [my $MAX_X = 2] = $#matrix;
   $boundaries [my $MIN_Y = 3] = 0;
my $boundary_change = 0;     

my $X = 0;
my $Y = 1;

#
# Current pointer and direction.
#
my (@position, @direction);
    @position  [$X, $Y] = (0, 0);
    @direction [$X, $Y] = (0, 1);


my $comma = "";
while ($boundaries [$MIN_X] <= $boundaries [$MAX_X] &&
       $boundaries [$MIN_Y] <= $boundaries [$MAX_Y]) {
    #
    # Print the value at the current position.
    #
    print $comma, $matrix [$position [$X]] [$position [$Y]];
    $comma = ", ";

    #
    # Where would we end up if we move one step.
    #
    my @next_position = ($position [$X] + $direction [$X],
                         $position [$Y] + $direction [$Y]);

    #
    # Next if we're still in bounds.
    #
    if ($boundaries [$MIN_X] <= $next_position [$X] &&
                                $next_position [$X] <= $boundaries [$MAX_X] &&
        $boundaries [$MIN_Y] <= $next_position [$Y] &&
                                $next_position [$Y] <= $boundaries [$MAX_Y]) {
        @position = @next_position;
        next;
    }

    #
    # We're running off of the matrix, change direction, and
    # update or decrement a minimum or maximum value.
    # Note that we always hit boundaries in the same order.
    #
    $boundaries [$boundary_change] += ($boundary_change == 0 ||
                                       $boundary_change == 3) ? 1 : -1;
    $boundary_change = ($boundary_change + 1) %4;

    #
    # Rotate the movement direction 90 degrees clockwise,
    # and update the position.
    #
    @direction = ($direction [$Y], -$direction [$X]);
    @position  = ($position [$X]  + $direction [$X],
                  $position [$Y]  + $direction [$Y]);
}

print "\n";

__END__

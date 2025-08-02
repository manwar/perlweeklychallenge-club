#!/usr/bin/perl
use strict;
use warnings;

=begin
BFS (Breadth-First Search) seems to be the best solution for finding the
shortest path for the knight's move problem on a chessboard.

1. Shortest Path Guarantee: BFS explores all possible moves level by level
(i.e., all positions reachable in one move, then all positions reachable
in two moves, and so on).

2. Simplicity: BFS is straightforward to implement and understand. It uses
a queue to explore nodes in the correct order and ensures that each node
is visited only once.
=cut

# Solution

# Knight's possible moves
my @moves = ([2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]);

# Convert chess notation to coordinates
sub notation_to_coords {
    my ($col, $row) = ($_[0] =~ /([a-h])([1-8])/);

    return (ord($col) - ord('a'), $row - 1);
}

# Check if a position is on the board
sub is_on_board {
    return $_[0] >= 0 && $_[0] < 8 && $_[1] >= 0 && $_[1] < 8;
}

# Find the shortest path using BFS
sub knight_shortest_path {

    my ($in_1, $in_2) = @_;

    # $start and $end are references to arrays containing the x and y
    # coordinates of the starting and ending positions.
    my $start = [notation_to_coords($in_1)];
    my $end = [notation_to_coords($in_2)];

    # Initialize the queue with the start position and depth 0
    my @queue = ([$start, 0]);

    # Track visited positions using a hash
    my %visited = ("$start->[0],$start->[1]" => 1);

    # Continue while there are elements in the queue
    while (@queue) {

        # Dequeue the first element
        my ($current, $depth) = @{shift @queue};

        # Extract current x and y coordinates
        my ($x, $y) = @$current;

        # Return depth if end position is reached
        return $depth if $x == $end->[0] && $y == $end->[1];

        # Iterate over all possible knight moves
        for my $move (@moves) {

            # Calculate new position
            my ($new_x, $new_y) = ($x + $move->[0], $y + $move->[1]);

            # Check if the new position is on the board and not visited
            if (is_on_board($new_x, $new_y) && !$visited{"$new_x,$new_y"}) {

                # Enqueue the new position with incremented depth
                push @queue, [[$new_x, $new_y], $depth + 1];

                # Mark the new position as visited
                $visited{"$new_x,$new_y"} = 1;
            }
        }
    }
    # -1 if no path is found (shouldn't happen on a standard chessboard)
    return(-1);
}

# Tests

my ($start, $end);

# Example 1
$start = "g2";
$end = "a8";
print( knight_shortest_path($start, $end), "\n") ;  # Output: 4

# Example 2
$start = "g2";
$end = "h2";
print( knight_shortest_path($start, $end), "\n"); # Output: 3

# Example 3
$start = "d5";
$end = "c7";
print( knight_shortest_path($start, $end), "\n"); # Output: 1

# Example 4
$start = "e3";
$end = "e1";
print( knight_shortest_path($start, $end), "\n"); # Output: 2


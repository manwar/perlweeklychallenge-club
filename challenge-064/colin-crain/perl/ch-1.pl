#! /opt/local/bin/perl
#
#       six_blocks_way.pl
#
#     TASK #1 › MINIMUM SUM PATH
#
#     Submitted by: Mohammad S Anwar
#     Remelted and Refined by: RYAN THOMPSON
#
#         Given an m × n matrix with non-negative integers, write a
#         script to find a path from top left to bottom right which
#         minimizes the sum of all numbers along its path. You can only
#         move either down or right at any point in time.
#
#         EXAMPLE
#
#         Input:
#
#             [ 1 2 3 ]
#             [ 4 5 6 ]
#             [ 7 8 9 ]
#
#         The minimum sum path looks like this:
#
#             1→2→3
#                 ↓
#                 6
#                 ↓
#                 9
#
#         Thus, your script could output: 21 ( 1 → 2 → 3 → 6 → 9 )
#
#         METHOD
#
#         What we have here is a matrix of values, located at the points
#         of a multidimensional array. We are connecting adjacent points
#         with potential pathways, but restricting travel on those
#         pathways to only the left-to-right and top-to-bottom
#         directions. We need a method to follow routes through this
#         grid from point to point, tallying the values as we go. From
#         this we can determine the correct answer.
#
#         The structure we have made is known as a Directed Acyclic
#         Graph, and is useful to model many things with a series of
#         choices towards a goal. We will start by looking at the
#         underlying structure of a simple 3×4 array, with the points
#         labeled, rather than the values stored there:
#
#                 0,0     0,1     0,2     0,3
#
#                 1,0     1,1     1,2     1,3
#
#                 2,0     2,1     2,2     2,3
#
#         rotating the whole thing clockwise 45° makes the underlying graph easier
#         to see.
#
#                          (0,0)      <-- START
#                          ⬋   ⬊
#                      (1,0)   (0,1)
#                      ⬋   ⬊   ⬋   ⬊
#                  (2,0)   (1,1)   (0,2)
#                      ⬊   ⬋   ⬊   ⬋   ⬊
#                      (2,1)   (1,2)   (0,3)
#                          ⬊   ⬋   ⬊   ⬋
#                          (2,2)   (1,3)
#                              ⬊   ⬋
#                              (2,3)  <-- END
#
#         It’s like a tree that links back into itself, and we progress
#         from top to bottom, traveling inexorably downward, as in a
#         pachinko machine with only one pocket. There’s a juicy
#         metaphor in there somewhere. In any case as can easily be seen
#         there are many ways to proceed, but if we remain bound to the
#         restrictions we will always end up at the same endpoint.
#
#         When situated at any given point, on the other hand, we are
#         only allowed at maximum two choices in direction. If we build
#         a recursive function that will follow each open pathway
#         available at the current node, by the time we get to the
#         endpoint we will have logged every possible route. Then we can
#         take those routes, as lists of points, and do a lookup to the
#         original values at each point to do the sums. The smallest of
#         these is the solution. Because we are asked to find “a path”
#         with the minimal sum, in the case of multiple equal answers
#         any one will do.
#
#         Walking down the script we have an input section, where we
#         also determine the endpoint. We then find our routes, using a
#         find_node() routine similar to that in the Raku in logic, but
#         in this case bifurcating into two independent forks for
#         downward pointing edges and rightward.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $graph = [   [  1,  16,  12,  43,  48,  19 ],
                [ 13,   7,   9,  16,  26,  8  ],
                [ 23,  18,   6,  11,  15,  17 ],
                [ 22,  33,  28,   5,  36,  32 ],
                [ 38,  43,   9,  46,   3,  42 ],
                [ 56,   4,  66,  76,  25,   2 ],
                [ 27,  10,  58,  14,  68,  52 ]   ];

my $endpoint = [$graph->@* - 1, $graph->[0]->@* - 1];

## determine the paths through the grid
my @paths;
my $startpoint = [0,0];
my $path = [$startpoint];
find_nodes( $path, $startpoint );

## sum totals to find the smallest
my $minsum = "+Inf";
my $minpath;
for $path (@paths) {
    my $sum = 0;
    $sum += $graph->[@$_[0]][@$_[1]] for @$path;
    if ($sum < $minsum) {
        $minsum  = $sum;
        $minpath = $path;
    }
}

## output
say "minimum sum path:";
print join ' -> ', map { $graph->[@$_[0]][@$_[1]] } @$minpath;
say "\nsum is $minsum";

## ## ## ## ## SUBS:

sub find_nodes {
    my ( $path, $point ) = @_;
    if ( $point->[0] == $endpoint->[0] &&
         $point->[1] == $endpoint->[1]    ) {
        push @paths, $path;
        return;
    }
    unless ($point->[0] + 1 > $endpoint->[0]) {
        my $next_point = [$point->[0] + 1, $point->[1]];
        my $new_path = [$path->@*, $next_point];
        find_nodes( $new_path, $next_point)
    }
    unless ($point->[1] + 1 > $endpoint->[1]) {
        my $next_point = [$point->[0], $point->[1] + 1];
        my $new_path = [$path->@*, $next_point];
        find_nodes( $new_path, $next_point)
    }
}
## refactoring rejected for clarity: (works fine, though)
#
# sub find_nodes {
#     my ( $path, $point ) = @_;
#     if ( $point->[0] == $endpoint->[0] &&
#          $point->[1] == $endpoint->[1]    ) {
#         push @paths, $path;
#         return;
#     }
#     for ([$point->[0] + 1, $point->[1]], [$point->[0], $point->[1] + 1]) {
#         next if ($_->[0] > $endpoint->[0] || $_->[1] > $endpoint->[1]);
#         my $new_path = [$path->@*, $_];
#         find_nodes( $new_path, $_)
#     }
# }

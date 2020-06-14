#!/usr/bin/env perl6
#
#
#       six_blocks_away.raku
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
#         rotating the whole thing clockwise 45° makes the underlying
#         graph easier to see.
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

#         For the Raku solution I wanted to build some classes to
#         compartmentalize the ideas of the graph and its vertices. It
#         seemed a good way to separate the underlying structure from
#         the data. I thought about serializing the input grid, with an
#         x and y value followed by the values in a long list, but
#         decided it distracted from the logic while providing little
#         gain, so I hardwired in a crafted example array. There is a -v
#         verbose command line switch though, which adds a pretty
#         printing of the original grid and a list of the point
#         coordinates of the vertices in the final route.
#
#         To start we need a simple Vertex, which holds an x and y
#         coordinate and a gist method for display, as (x,y).
#
#         In the Grid class for data we have just the input grid. We
#         have added methods to:
#
#             •find the endpoint and return it (as a Vertex)
#             •find the theoretical following two Vertex points, which
#               are composed by adding 1 to either the x value or the y
#               value
#             •determine whether a given Vertex is within the Grid or
#               not
#             •sum the values referenced along a given route, by mapping
#               to the $.grid data and using the sum [+] metaoperator.
#
#         In the MAIN block we have input, output and two logic
#         sections, to trace the paths and determine the minimum sum.
#
#         The find_nodes() routine first checks whether the given Vertex
#         is the endpoint, logging the completed chain and returning if
#         so. It then posits two potential new Vertexes, treating their
#         creator methods as proper first-order functions in a for loop.
#         For each of these we check to see whether its remains within
#         the Grid, and if so we clone the route so far, extending it
#         with that new Vertex, and recurse with the new parameters.
#         Eventually all routes lead to the endpoint and terminate.
#
#         Summing a given list of vertices from outside is using the
#         data from the Grid object to compute and so it seems a method
#         of that object is a good place to put that logic. On the other
#         hand, using those sums to find the minimum sum of a variety of
#         routes isn’t particularly intrinsic to the data structure so
#         we leave that in the MAIN block. This task is easily
#         dispatched in Raku:
#
#             my $minpath = @paths.min( { $graph.sum_route( $_ ) } );
#
#         In this method we are providing a code block to apply to the
#         data; it returns the minimum value of the array, as determined
#         by those transformed values returned by the block. This design
#         pattern is available for all of the min/max list functions, as
#         if you ask me is very, very cool. Think of it as being
#         analogous to handing sort() a block to determine the ordering.
#         One thing though, because we’ve used this first-class function
#         option, after we’ve found the minimum route we’ll still need
#         to compute the minimum sum for that minimal route we’ve found.
#         We could use a map and a hash and save the value, but this way
#         is rather ridiculously easy and succinct so we’re going to go
#         with that.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

class Vertex {
    has Int $.x;
    has Int $.y;

    method gist {
        return "($.x,$.y)";
    }
}

class Grid {
    ## a special case of a rectangular grid DAG where we can
    ## only progress rightwards or downwards between vertices
    has $.grid;

    method endpoint () {
        ## lower right corner of the grid
        return Vertex.new: :x(self.grid[0].end), :y(self.grid.end)
    }

    method down_edge ($vertex) {
        return Vertex.new: :x($vertex.x), :y($vertex.y + 1)
    }

    method right_edge ($vertex) {
        return Vertex.new: :x($vertex.x + 1), :y($vertex.y)
    }

    method sum_route ($route) {
        ## given a path of vertices, return the sum of the values
        my $sum = [+] $route.map( { $.grid[.y][.x] } );
        return $sum;
    }

    method out_of_bounds ($vertex) {
        ## Bool is vertex outside the grid?
        return ($vertex.x > self.endpoint.x || $vertex.y > self.endpoint.y)
                ?? True
                !! False
    }

}

sub MAIN (Bool :$v = False) {

    ## input
    my @grid = [1,  16, 12, 43, 48, 19],
               [13,  7,  9, 16, 26,  8],
               [23, 18,  6, 11, 15, 17],
               [22, 33, 28,  5, 36, 32],
               [38, 43,  9, 46,  3, 42],
               [56,  4, 66, 76, 25,  2],
               [27, 10, 58, 14, 68, 52];

    my $graph = Grid.new: :grid(@grid);
    my @paths;
    my $startpoint = Vertex.new: :x(0), :y(0);
    my $route = [$startpoint];

    find_nodes( $route, $startpoint, $graph, @paths );

    my $minpath = @paths.min( { $graph.sum_route( $_ ) } );
    my $minsum = $graph.sum_route( $minpath );

    ## output
    say "grid:"                                 if $v;
    (.fmt( '%3d', '  ' ).say for $graph.grid)   if $v;
    say "minimum sum: $minsum";
    say "route:";
    say $minpath                                if $v;
    $minpath.map( { $graph.grid[.y][.x] } ).join( ' ➔ ' ).say;
}

sub find_nodes ($route, $vertex, $graph, @paths) {

    if $vertex eqv $graph.endpoint( ) {
        @paths.push: $route;
        return;
    }
    for ($graph.down_edge( $vertex ), $graph.right_edge( $vertex )) -> $next_vertex {
        next if $graph.out_of_bounds( $next_vertex );
        my $new_path = [|$route, $next_vertex];
        find_nodes( $new_path, $next_vertex, $graph, @paths );
    }
}

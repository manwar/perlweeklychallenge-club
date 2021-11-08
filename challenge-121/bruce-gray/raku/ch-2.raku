# Travelling Salesman Problem - British Museum algorithm
sub tsp_short ( @G ) {
    sub cost_of ( @path ) {
        my $cost = sum map { @G[ .[0] ; .[1] ] },
                   (0, @path.head), (@path.tail, 0), |@path.rotor(2 => -1);

        return { :@path, :$cost };
    }

    return ( 1 .. @G.end ).permutations.map(&cost_of).min(*.<cost>);
}

# Travelling Salesman Problem - Branch-and-bound algorithm
sub tsp ( @G where { .elems == .[0].elems } ) {
    my @visited = False xx @G.elems;
    my %best = cost => Inf, path => [];

    sub minimum-weight-Hamiltonian-cycle ( $current_position, $cost_so_far, @path )  {

        my @current_row := @G[$current_position];
        my $cost = $cost_so_far + @current_row[0];

        # "Bound": No need to recurse further down if this branch has already lost.
        return if $cost > %best<cost>;

        my @could_visit_next = @visited.grep(:k, *.not) or do {

            if @current_row[0] { # Path exists back to origin
                %best = :$cost, :@path if $cost < %best<cost>;
            }

            # Recursion at max depth when @could_visit_next is empty,
            # regardless of whether path can return to origin.
            return;
        };

        # "Branch" down to every unvisited node at this level.
        for @could_visit_next -> $i {
            my $node_cost = @current_row[$i]
                or next; # Zero would mean same node or no route to node.

            # Mark as visited, recurse (incrementing cost&path), then undo the mark.
            @visited[$i] = True;
            &?ROUTINE( $i, $cost_so_far + $node_cost, (|@path, $i) );
            @visited[$i] = False;
        }
    }

    @visited[0] = True;
    minimum-weight-Hamiltonian-cycle( 0, 0, [] );

    return %best;
}

my @tests =
    (
        ( 0, 5, 2, 7 ),
        ( 5, 0, 5, 3 ),
        ( 3, 1, 0, 6 ),
        ( 4, 5, 4, 0 ),
    ),

    # https://people.sc.fsu.edu/~jburkardt/datasets/tsp/tsp.html , P01
    # Runs in 9m25s
    (
        <  0 29 82 46 68 52 72 42 51 55 29 74 23 72 46 >,
        < 29  0 55 46 42 43 43 23 23 31 41 51 11 52 21 >,
        < 82 55  0 68 46 55 23 43 41 29 79 21 64 31 51 >,
        < 46 46 68  0 82 15 72 31 62 42 21 51 51 43 64 >,
        < 68 42 46 82  0 74 23 52 21 46 82 58 46 65 23 >,
        < 52 43 55 15 74  0 61 23 55 31 33 37 51 29 59 >,
        < 72 43 23 72 23 61  0 42 23 31 77 37 51 46 33 >,
        < 42 23 43 31 52 23 42  0 33 15 37 33 33 31 37 >,
        < 51 23 41 62 21 55 23 33  0 29 62 46 29 51 11 >,
        < 55 31 29 42 46 31 31 15 29  0 51 21 41 23 37 >,
        < 29 41 79 21 82 33 77 37 62 51  0 65 42 59 61 >,
        < 74 51 21 51 58 37 37 33 46 21 65  0 61 11 55 >,
        < 23 11 64 51 46 51 51 33 29 41 42 61  0 62 23 >,
        < 72 52 31 43 65 29 46 31 51 23 59 11 62  0 59 >,
        < 46 21 51 64 23 59 33 37 11 37 61 55 23 59  0 >,
    ),
;
say .&tsp_short for @tests.head;
say .&tsp for @tests;

sub shortest-path-BFS ( $start-node, $stop-node, %adjacency-list --> List ) {
    my @queue = ( $start-node, );

    my %visited is SetHash = $start-node => True;

    while @queue {
        my @path = @queue.shift.list;
        my $node = @path.tail;

        return @path.List if $node eq $stop-node;

        for %adjacency-list{$node}.list -> $neighbour {
            @queue.push: (flat @path, $neighbour) if !%visited{$neighbour};
            %visited{$neighbour} = True;
        }
    }
    return Nil;
}
sub make-adjacency-list ( @routes ) {
    my %adj; # Hash of Lists. Any list could contain duplicates.
    for @routes -> @chain-of-routes {
        for @chain-of-routes.rotor(2 => -1) {
            %adj{ .[0] }.push: .[1];
            %adj{ .[1] }.push: .[0];
        }
    }
    # Using a unique sorted list instead of a HoH allows us to have
    # a stable predicable single expected output for any test case
    # that actually has multiple possible shortest-paths.
    return %adj.map: { .key => .value.sort.squish };
}
sub task2 ( $start, $stop, @routes_LoL ) {
    my %aL = make-adjacency-list(@routes_LoL);
    return shortest-path-BFS( $start, $stop, %aL ) // -1;
}


my @tests =
    (   1,   7, ( (1,2,6), (5,6,7)                 ), (1,2,6,7)   ),
    (   2,   5, ( (1,2,3), (4,5,6)                 ), -1          ),
    (   1,   7, ( (1,2,3), (4,5,6), (3,8,9), (7,8) ), (1,2,3,8,7) ),

    # Same three tests from original task, as letters.
    ( 'A', 'G', ( <A B F>, <E F G>                 ), <A B F G>   ),
    ( 'B', 'E', ( <A B C>, <D E F>                 ), -1          ),
    ( 'A', 'G', ( <A B C>, <D E F>, <C H I>, <G H> ), <A B C H G> ),

    # From mark-anderson , The graph from https://www.youtube.com/watch?v=T_m27bhVQQQ&t=360s
    ( 'A', 'H', ( <A C F>, <A G J>, <A B D>,
                  <B A C>, <B D H>,
                  <C A G>, <C F J>, <C G J>,
                  <D B A>, <D G J>, <D H J>,
                  <F C G>, <F J H>,
                  <G A B>, <G C A>, <G D H>, <G J F>,
                  <H D G>, <H J G>,
                  <J F C>, <J G A>, <J H D>           ), <A B D H>),
    # Same, with edges only given in pairs.
    ( 'A', 'H', ( <A B>, <A C>, <B D>, <C F>, <C G>, <D G>, <D H>, <F J>, <G J>, <H J> ), <A B D H>),
    # Same, in further reduced form.
    ( 'A', 'H', ( <A B D H J F C A>, <C G D>, <G J> ), <A B D H>),
    # Same, in single path (but visiting nodes more than once).
    ( 'A', 'H', ( <A B D H J F C A G J G C G D>, ), <A B D H>),
;
use Test;
plan +@tests;
for @tests -> ( $start, $stop, $routes, $expected ) {
    is-deeply task2( $start, $stop, $routes ), $expected;
}

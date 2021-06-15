#!/usr/bin/env raku

class Graph {
    has @.edges;

    method moves-from( :$point ) {
        @.edges.grep( *.key == $point ).map( *.value );
    }
}

#|( Given a triangle of height $N return the possible routes from the top 
 To the bottom right
)
multi sub MAIN(UInt $N) {
    say traverse-triangle($N).join(", ");
}

multi sub MAIN("test") is hidden-from-USAGE {
    use Test;
    ok traverse-triangle(1) (==) <R LH>;
    ok traverse-triangle(2) (==) <RR LHR LHLH LLHH RLH LRH>;
    my ( $g1, $s1, $e1 ) = make-triangle-graph( size => 1 );
    my ( $g2, $s2, $e2 ) = make-triangle-graph( size => 2 );
    my ( $g3, $s3, $e3 ) = make-triangle-graph( size => 3 );
    is $s1, 0;
    is $e1, 2;
    is $s2, 0;
    is $e2, 5;
    is $s3, 0;
    is $e3, 9;
    is $g1.edges.elems, 3;
    is $g2.edges.elems, 9;
    is $g3.edges.elems, 18;
    ok $g1.moves-from( point => 0 ) (==) ( ('L', 1), ('R', 2) );
    done-testing;
}

sub traverse-triangle( $size ) {
    my ( $graph, $current, $end ) = make-triangle-graph( :$size );

    return travel-to( $graph, $current, $end );
}

multi sub travel-to( Graph $g, Int $s, Int $e where $e == $s ) {
    return [""];
}

multi sub travel-to( Graph $g, Int $point, Int $e ) {
    my @routes = [];

    for $g.moves-from(:$point).map( -> ($d, $p ) { [$d] X~ travel-to($g,$p,$e) } ) -> @p {
        @routes.push($_) for @p.flat;
    }

    return @routes;
}


sub make-triangle-graph( :$size ) {
    my $start = 0;
    my @points = [$start];
    my $end = @points[*-1];
    my @edges;
    for (1..$size) -> $width {
        my @next = [$end+1..($end+$width+1)];
        for  @points Z @next.rotor(2=>-1) -> ($s,@n) {
            @edges.push( $s => ( 'L', @n[0]) );
            @edges.push( $s => ( 'R', @n[1]) );
            @edges.push( @n[0] => ( 'H', @n[1] ) );
        }
        @points = @next;
        $end = @points[*-1];
    }

    return Graph.new( :@edges ), $start, $end;
}
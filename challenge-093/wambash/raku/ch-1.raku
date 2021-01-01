#!/usr/bin/env raku

class Point {
    has $.x;
    has $.y;

    multi method COERCE ( ($x,$y) ) {
        self.new: :$x, :$y
    }
}

class Line {
    has $.a;
    has $.b;

    multi method from-points(Point:D() $p, Point:D() $q) {
        when $p.x eqv $q.x { self.new: a=> Inf, b => $p.x }
        default {
            my $a = ($q.y-$p.y) / ($q.x-$p.x);
            my $b = $p.y-$a*$p.x;

            self.new: :$a, :$b;
        }
    }
}

sub max-points ( +@a ) {
    @a.combinations(2)
    andthen .categorize: -> [$p,$q] {(.a,.b).raku with Line.from-points( $p, $q )}, as => {|$_}\
    andthen .map:  { .key => .value.unique }\
    andthen .max: *.value.elems
}


multi MAIN(
    +@point    #= 1 1  2 2   3 1  1 3  3 3  5 3  4 3
) {
    @point
    andthen .batch: 2
    andthen .&max-points
    andthen .value.elems
    andthen .say
}

multi MAIN(Bool :$test!) {
    use Test;

    my Point() @p = (1,3),(2,5);
    is-deeply Line.from-points(|@p),         Line.new( a=> 2.0, b=> 1.0 );
    is-deeply Line.from-points((1,5),(3,7)), Line.new( a=> 1.0, b=> 4.0 );
    is-deeply Line.from-points((1,2),(1,4)), Line.new( a=> Inf, b=> 1   );

    my Point() @a=(1,1), (2,2), (3,1), (1,3), (3,3),(5,3),(4,3);
    is max-points( (1,1), (2,2), (3,3) ).value.elems, 3;
    is max-points( (1,1), (2,2), (3,1), (1,3), (5,3) ).value.elems, 3;
    is max-points( (1,1), (2,2), (3,1), (1,3), (5,3) ).key, (-1/1,4/1).raku;
    is max-points( @a ).key, (0/1, 3/1).raku;
    done-testing;
}

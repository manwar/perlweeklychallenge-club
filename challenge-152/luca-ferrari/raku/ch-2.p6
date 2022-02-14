#!raku

class Point {
    has Int $.x;
    has Int $.y;
}


class Rectangle {
    has Point $.corner-left;
    has Point $.corner-right;

    method area() {
        abs( $!corner-right.x - $!corner-left.x )
        * abs( $!corner-right.y - $!corner-left.y );
    }


    method !is-overlapping( Rectangle $r ) {
        ( $!corner-left.x <= $r.corner-left.x <= $!corner-right.x
           ||  $!corner-left.x <= $r.corner-righ.x <= $!corner-right.x )
        &&
        ( $!corner-left.y <= $r.corner-left.y <= $!corner-right.y
          ||  $!corner-left.y <= $r.corner-right.y <= $!corner-right.y );

    }

    method overlapping-area( Rectangle $r ) {
        return 0 if ! self!is-overlapping( $r );

        my $left = Point.new( x => max( $!corner-left.x, $r.corner-left.x ),
                              y => max( $!corner-left.y, $r.corner-left.y )
                            );
        my $right = Point.new( x => min( $!corner-right.x, $r.corner-right.x ),
                               y => min( $!corner-right.y, $r.corner-right.y )
                             );

        my Rectangle $overlapping = Rectangle.new:
                                    corner-left =>  $left,
                                    corner-right => $right;
        return $overlapping.area;

    }
}

# Example:
# $ raku ch-2.p6 -1 0 2 2   0 -1 4 4
# 22
#
# $ raku ch-2.p6 -3 -1 1 3 -1 -3 2 2
# 25
sub MAIN(  *@points where { @points.elems == 8 && @points.grep( * ~~ Int ) == @points.elems } ) {
    my @corners = @points.rotor( 2 ).map: { Point.new( x => $_[ 0 ].Int, y => $_[ 1 ].Int ) };
    my Rectangle ( $r1, $r2 ) = @corners.rotor( 2 ).map: { Rectangle.new(
                                                                 corner-left => $_[ 0 ],
                                                                 corner-right => $_[ 1 ] ) };
    "{ $r1.area + $r2.area - $r1.overlapping-area( $r2 ) }".say;
}

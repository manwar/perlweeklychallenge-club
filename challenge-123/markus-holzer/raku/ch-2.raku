# Given four points, find out if they form a square

class Point {
    has Int $.x;
    has Int $.y;
}

my @points = Point.new( x => 10, y => 20 ),
             Point.new( x => 20, y => 20 ),
             Point.new( x => 20, y => 10 ),
             Point.new( x => 10, y => 10 );

say ( '2', '4' ) ≡ .keys && .<4> * 2.sqrt ≅ .<2>
    given @points
        .combinations( 2 )
        .map( { ( ( .[1].x - .[0].x)² + (.[1].y - .[0].y)² ).sqrt } )
        .Bag
        .invert
        .Hash;


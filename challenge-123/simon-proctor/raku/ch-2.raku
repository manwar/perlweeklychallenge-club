#!/usr/bin/env raku

multi MAIN( 'Test' ) {
    use Test;
    ok  is-square( (10, 20), (20, 20), (20, 10), (10, 10) );
    ok !is-square( (12, 24), (16,10), (20, 12), (18, 16) );
    ok  is-square( (0, 10),  (10, 0), (0, -10), (-10, 0) );
    is sq-dist-between( (0,0), (3,4) ), 25; 
    done-testing;
}

#| Given a list of 8 numbers (making up 4 points) of a quadrilateral return 1 or 0 depending on if it's a square
multi MAIN( Num() $x1, Num() $y1,
	    Num() $x2, Num() $y2,
	    Num() $x3, Num() $y3,
	    Num()$x4,  Num() $y4 ) {
    say +is-square( ($x1, $y1), ($x2, $y2), ($x3, $y3), ($x4, $y4) );
}

multi sq-dist-between( @p1, @p2 ) {
    ( @p1[0]-@p2[0] )² + ( @p1[1]-@p2[1] )²; 
}

multi is-square( @p1, @p2, @p3, @p4 ) {
    my @d = ( @p1, @p2, @p3, @p4 )
		.combinations(2)
		.map( -> @l { sq-dist-between( @l[0], @l[1] ) } )
		.sort;

    return ([~~] @d[0..3]) && ([~~] @d[4..5]);
}

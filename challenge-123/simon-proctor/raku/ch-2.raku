#!/usr/bin/env raku

multi MAIN( 'Test' ) {
    use Test;
    ok  is-square( 10, 20, 20, 20, 20, 10, 10, 10 );
    ok !is-square( 12, 24, 16,10, 20, 12, 18, 16 );
    ok  is-square( 0, 10, 10, 0, 0, -10, -10, 0 );
    is sq-dist-between( 0,0, 3, 4 ), 25; 
    done-testing;
}

#| Given a list of 8 numbers (making up 4 points) of a quadrilateral return 1 or 0 depending on if it's a square
multi MAIN( Num() $x1, Num() $y1,
	    Num() $x2, Num() $y2,
	    Num() $x3, Num() $y3,
	    Num()$x4,  Num() $y4 ) {
    say +is-square(  $x1, $y1, $x2, $y2, $x3, $y3, $x4, $y4 );
}

multi sq-dist-between( $x1, $y1, $x2, $y2 ) {
    ( $x1-$x2 )² + ( $y1-$y2 )²; 
}

multi is-square( $x1, $y1, $x2, $y2, $x3, $y3, $x4, $y4 ) {
    my ( $d1, $d2, $d3, $d4, $d5, $d6 ) = (
      sq-dist-between( $x1,$y1, $x2, $y2),
      sq-dist-between( $x1,$y1, $x3, $y3),
      sq-dist-between( $x1,$y1, $x4, $y4),
      sq-dist-between( $x2,$y2, $x3, $y3),
      sq-dist-between( $x2,$y2, $x4, $y4),
      sq-dist-between( $x3,$y3, $x4, $y4),
    ).sort;
    return $d1 ~~ $d2 ~~ $d3 ~~ $d4 && $d5 ~~ $d6;
}

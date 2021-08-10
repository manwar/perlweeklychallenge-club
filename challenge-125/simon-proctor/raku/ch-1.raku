#!/usr/bin/env raku

my @odds = (1,*+2...*).cache;

multi sub MAIN('test') is hidden-from-USAGE {
    use Test;

    is py-triples(3), ( (3,4,5) );
    is py-triples(4), ( (3,4,5) );
    is py-triples(5), ( (3,4,5), (5,12,13) );
    is py-triples(6), ();
    is py-triples(13), ( (5,12,13), (13, 84, 85) );

    done-testing;
}

#| Given a positive Integer $N print the pythagorean triples it's found in or -1 if there are none
multi sub MAIN(UInt $N where * > 0) {
    my @trips = py-triples( $N );
    say -1 unless +@trips;
    .join(",").say for @trips; 
}

sub py-triples(UInt $N) {
    return ((1..($N² div 2)) X, (1..($N² div 2)+1)).hyper
                                     .grep( -> ($a,$b) { $b >= $a } )
                                     .grep( -> ($a,$b) { $N² + $a² == $b² || $N² == $a² + $b² } )
                                     .map(  -> ($a,$b) { ( $a, $b, $N ).sort } );
}
  

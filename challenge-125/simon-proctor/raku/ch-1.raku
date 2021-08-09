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
    my @out;
    
    my @odds = (1,*+2...* >= $N).cache;

    my @pairs = (@odds X, @odds).grep( -> ($m, $n) { $m > $n } );
    
    for @pairs -> ( $m, $n ) {
        if ( $N ~~ $m * $n || $N ~~ ($m²-$n²)/2 || $N ~~ ($m² + $n²)/2 ) {
            push @out, $ = ( ($m * $n), ( ($m²-$n²)/2), ( ($m² + $n²)/2 ) );
        }
    }
    
    return @out;
}
  

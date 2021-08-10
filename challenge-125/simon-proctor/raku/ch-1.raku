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
    
    #my @odds = (1,*+2...* >= $N).cache;
    
    #return (@odds X, @odds).hyper.grep( -> ($m, $n) { $m > $n } ).map( -> ( $m, $n ) { note ($m,$n); (  ($m * $n), ( ($m²-$n²)/2), ( ($m² + $n²)/2 ) ) } ).grep( -> $pos { note $pos; $N ~~ $pos.any; } );

    my $as = start ((1..^$N) X, (1..^$N²)).hyper
                                  .grep( -> ($a,$b) { $b >= $a } )
                                  .grep( -> ($a,$b) { $N² == $a² + $b² } )
                                  .map( -> ($a, $b) { ( $a, $b, $N ).sort } );

    my $cs = start (($N^..($N² div 2)) X, ($N^..($N² div 2)+1)).hyper
                                     .grep( -> ($a,$c) { $c >= $a } )
                                     .grep( -> ($a,$c) { $N² + $a² == $c² } )
                                     .map( -> ($a, $c) { ( $a, $N, $c ).sort } );
                                     
    await $as, $cs;
    
    return |$as.result , |$cs.result;

                                                                                                                       
}
  

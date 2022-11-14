#!/usr/bin/env raku

multi sub MAIN ( "TEST" ) is hidden-from-USAGE {
    use Test;
    ok ! passes( ( 1,2,3,4 ) );
    ok   passes( ( 1,2,0,5 ) );
    ok   passes( ( 2,6,3,1 ) );
    ok ! passes( ( 4,5,2,3 ) );
    ok ! passes( ( |(1..1000000) ) );
    ok   passes( ( |(1..1000000), 2000000 ) );
    ok   passes( ( |(1..500000), 2000000, |(510000..1000000) ) );
    
    done-testing;
}

multi sub passes ( @list ) {
    my @sorted = @list.sort;
    return @sorted[*-1] >= @sorted[*-2] * 2;
}

#|( Given a list of ints returns true if the largest element in the list
 Is at least twice the size of the next largest element
 Returns True or False)
multi sub MAIN(
    *@list where { *.all ~~ IntStr } #= List of ints to check
) {
    
}

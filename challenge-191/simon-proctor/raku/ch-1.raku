#!/usr/bin/env raku

multi sub MAIN ( "TEST" ) is hidden-from-USAGE {
    use Test;
    ok   passes( [1] );
    ok ! passes( [] );
    ok ! passes( ( 1,2,3,4 ) );
    ok   passes( ( 1,2,0,5 ) );
    ok   passes( ( 2,6,3,1 ) );
    ok ! passes( ( 4,5,2,3 ) );
    ok ! passes( ( |(1..1000000) ) );
    ok   passes( ( |(1..1000000), 2000000 ) );
    ok ! passes( ( |(1..1000000), 2000000, 2000000 ) );
    ok   passes( ( |(1..1000000), 2000000 ).pick(*) );

    ok   faff( [1] );
    ok ! faff( [] );
    ok ! faff( ( 1,2,3,4 ) );
    ok   faff( ( 1,2,0,5 ) );
    ok   faff( ( 2,6,3,1 ) );
    ok ! faff( ( 4,5,2,3 ) );
    ok ! faff( ( |(1..1000000) ) );
    ok   faff( ( |(1..1000000), 2000000 ) );
    ok ! faff( ( |(1..1000000), 2000000, 2000000 ) );
    ok   faff( ( |(1..1000000), 2000000 ).pick(*) );
    
    done-testing;
}

multi sub MAIN( "TIMING" ) is hidden-from-USAGE {
    use Benchmark;
    my @random = ( |(1..100000), 200000 ).pick(*);
    say timethis(10000,"&passes(@random)").join(",");
    say timethis(10000,"&faff(@random)").join(",");
    @random = ( |(1..100000) ).pick(*);
    say timethis(10000,"&passes(@random)").join(",");
    say timethis(10000,"&faff(@random)").join(",");

}

multi sub passes ( @ where *.elems == 1 ) { True }
multi sub passes ( @ where *.elems == 0 ) { False }

multi sub passes ( @list ) {
    my @sorted = @list.sort;
    return @sorted[*-1] >= @sorted[*-2] * 2;
}

sub faff (@list) {
    return False if ! @list;
    return True  if   @list.elems == 1;

    my ( $max, $next ) = @list[0,1];
    for ( @list ) -> $new {
        if ( $new > $max ) {
            ( $max, $next ) = ( $new, $max );
        } elsif ( $new > $next ) {
            $next = $new;
        }        
    }
    return $max >= $next * 2;
}

#|( Given a list of ints returns true if the largest element in the list
 Is at least twice the size of the next largest element
 Returns True or False)
multi sub MAIN(
    *@list where { *.all ~~ IntStr } #= List of ints to check
) {
    return passes( @list );
}

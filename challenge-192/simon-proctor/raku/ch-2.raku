#!/usr/bin/env raku

multi sub MAIN("TEST") is hidden-from-USAGE {
    use Test;
    is flatten-moves( [1,0,5] ), 4;
    is flatten-moves( [0,2,0] ), -1;
    is flatten-moves( [0,3,0] ), 2;
    done-testing;
}

multi sub MAIN( *@vals ) {
    flatten-moves( @vals.List ).say;
}

subset CanAverage of Array where -> @a { my $avg = ( ([+] @a) / @a.elems ); $avg ~~ $avg.Int };


multi sub flatten-moves( $ ) { -1 }

multi sub flatten-moves( CanAverage $v ) {
    my $moves = 0;
    my $avg =  ( ([+] $v) / $v.elems );
    my $point = 0;
    while ( (all( $v ) !~~ $avg) ) {
        if ( $v[$point] ~~ $avg ) {
            $point++;
            next;
        }
        if ( $v[$point] > $avg ) {
            $v[$point]--;
            $v[$point+1]++;
            $moves++;
            next;
        }
        if ( $v[$point] < $avg ) {
            $v[$point]++;
            $v[$point+1]--;
            $moves++;
            next;
        }

    }
    return $moves;
}

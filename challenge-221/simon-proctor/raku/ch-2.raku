#!/usr/bin/env raku

#|( Find the length of the longest arithmetic sequnce that
 can be made by removing elements from the given list
)
multi sub MAIN(
    *@vals #= lit of value to test 
              ) {
    longest-sequence( |@vals ).elems.say;
}

multi sub MAIN('TEST') is hidden-from-USAGE {
    use Test;
    ok arithmetic-sequence(4,7,10); 
    ok ! arithmetic-sequence(4,7,1);
    is longest-sequence( 9, 4, 7, 2, 10 ), (4,7,10);
    is longest-sequence( 3, 6, 9, 12 ), (3,6,9,12);
    is longest-sequence( 20, 1, 15, 3, 10, 5, 8), (20, 15, 10, 5);
    done-testing;
}

sub arithmetic-sequence( *@vals ) {
    [==] @vals.rotor( 2 => -1 ).map( -> ( $a,$b) { $a-$b } )
}

multi sub longest-sequence( *@vals where { arithmetic-sequence( @vals ) } ) {
    return @vals;
}

multi sub longest-sequence( *@vals ) {
    @vals.combinations(@vals.elems-1).map( -> @poss { longest-sequence( |@poss ) } ).sort( *.elems ).reverse.[0];
}

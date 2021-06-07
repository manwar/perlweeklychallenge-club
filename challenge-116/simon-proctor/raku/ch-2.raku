#!/usr/bin/env raku



#| Given a number output 1 if the sum of the squares of it's digits is a square.
multi sub MAIN (
    UInt $N where * >= 10 #= Number to test (Greater than equal to 10)
) {
    ( square-sum($N) ?? 1 !! 0 ).say; 
}

multi sub MAIN( "test" ) is hidden-from-USAGE {
    use Test;
    ok square-sum(34);
    ok square-sum(50);
    ok ! square-sum(52);
    done-testing;
}

sub square-sum( UInt \N ) {
    is-square( [+] N.comb().map( { $^a * $^a } ) );
}

sub is-square( UInt \N ) {
    sqrt(N) == sqrt(N).Int;
}
    

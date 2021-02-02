#!/usr/bin/env raku

use v6;

#| Given an int and a sorted list of ints output the index the first valus has (or should have) in the list
multi sub MAIN ( Int $N, #= Integer to check the location of
           *@N where @N.sort ~~ @N #= Sorted list of integers
         ) {
    say find-in-list($N,@N);
}

multi sub MAIN( "test" ) is hidden-from-USAGE {
    use Test;
    is( find-in-list( 3, [1,2,3,4] ), 2 );
    is( find-in-list( 6, [1,3,5,7] ), 3 );
    is( find-in-list( 10, [12,14,16,18] ), 0 );
    is( find-in-list( 19, [11,13,15,17] ), 4 );
    done-testing;
}

sub find-in-list( Int $n, @n ) {
    for @n.kv -> $i, $v {
        return $i if $v ~~ $n;
        return $i if $v > $n;
    }
    return @n.elems;
}

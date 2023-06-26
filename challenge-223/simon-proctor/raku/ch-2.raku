#!/usr/bin/env raku

multi sub MAIN('TEST') is hidden-from-USAGE {
    use Test;
    is max-value( ( 3,1,5,8 ) ), 167;
    is max-value( ( 1,5 ) ), 10;    
    done-testing;
}

#| Given a list of values work out the max value based on the challenge
multi sub MAIN( *@values ) {
    max-value( @values ).say;
}

multi sub max-value( @a where *.elems == 1 ) { @a[0] }
multi sub max-value( @a ) {
    (^(@a.elems)).map(
        -> $i {
            ( ($i > 0 ?? @a[$i-1] !! 1 ) *
            @a[$i] *
            ($i < @a.end ?? @a[$i+1] !! 1 ) ) +
            max-value( @a[|(0..$i-1),|($i+1..@a.end)] )
        } ).max;
}

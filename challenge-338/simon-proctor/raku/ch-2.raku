#!/usr/bin/env raku

multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is max-distance( (4, 5, 7), (9, 1, 3, 4) ), 6;
    is max-distance((2, 3, 5, 4), (3, 2, 5, 5, 8, 7) ), 6;
    is max-distance( (2, 1, 11, 3), (2, 5, 10, 2) ), 9;
    is max-distance( (1, 2, 3), (3, 2, 1) ), 2;
    is max-distance( (1, 0, 2, 3), (5, 0) ), 5;                    
    done-testing;
}

sub max-distance( @a, @b ) {
    (@a X- @b)>>.abs.max;
}

#| Given two comma seperated lists print the max distance between values
multi sub MAIN( $a #= Comma seperated list of numbers
                , $b #= Comma seperated lists of numbers
              ) {
    max-distance( $a.split(','), $b.split(',') ).say;
}

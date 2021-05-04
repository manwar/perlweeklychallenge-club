#!raku


sub MAIN( Int $needle = 39 ) {
    my @matrix = [  1,  2,  3,  5,  7 ]
                 , [  9, 11, 15, 19, 20 ]
                 , [ 23, 24, 25, 29, 31 ]
                 , [ 32, 33, 39, 40, 42 ]
                 , [ 45, 47, 48, 49, 50 ];

    "1".say and exit  if $_[ 0 ] <= $needle
                         && $_[ *-1 ] >= $needle
                         && $_.grep: $needle for @matrix;

    "0".say;
}

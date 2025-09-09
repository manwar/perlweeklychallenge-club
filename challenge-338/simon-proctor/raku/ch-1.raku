#!/usr/bin/env raku

multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is highest-row( [[4,  4, 4, 4],
                     [10, 0, 0, 0],
                     [2,  2, 2, 9]] ), 16;
    is highest-row( [[1, 5],
                     [7, 3],
                     [3, 5]]), 10;
    is highest-row( [[1, 2, 3],
                     [3, 2, 1]]), 6;
    is highest-row( [[2, 8, 7],
                     [7, 1, 3],
                     [1, 9, 5]] ),17;
    is highest-row( [[10, 20,  30],
                     [5,  5,   5],
                     [0,  100, 0],
                     [25, 25,  25]] ), 100;
    done-testing;
}

#| Given a list of comma seperated matrix rows print the highest sum of row values
multi sub MAIN( 
    *@rows #= Comma seperate list of matrix rows
) {
    highest-row( @rows.map(*.comb(/'-'?\d/)) ).say;
}

sub highest-row( @matrix ) {
    @matrix.map( -> @row { [+] @row } ).max;
}

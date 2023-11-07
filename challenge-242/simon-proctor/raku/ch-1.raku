#!/usr/bin/env raku

multi sub MAIN('test') is hidden-from-USAGE {
    use Test;
    is-deeply missing-values((1,2,3), (2,4,6)), [[1,3],[4,6]], 'Got expected missing values';
    is-deeply missing-values((2,4,6), (1,2,3)), [[4,6],[1,3]], 'Got expected missing values';
    is-deeply missing-values((1,2,3,3),(1,1,2,2)), [[3],[]], 'Second test';
    is-deeply missing-values((1,1,2,2),(1,2,3,3)), [[],[3]], 'Second test';
    done-testing;
}

subset CSV of Str where { $_ ~~ m/^ (\d+) * %% ',' $/ };

#| Given two comma seperated lists of integers print the lists of items missing from each list
multi sub MAIN(
    CSV $a, #= First list of ints
    CSV $b  #= Second list of ints
) {
    missing-values($a.split(','),$b.split(',')).map( '(' ~ *.join(',') ~ ')' ).join( " " ).say;
}

sub missing-values( @a, @b ) {
    return [ (@a (-) @b).keys.sort.Array, (@b (-) @a).keys.sort.Array];
}


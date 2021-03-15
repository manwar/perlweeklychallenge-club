#!raku


sub distance ( Str $start, Str $end ) {

    # special case: one string is nil
    return $start.chars if ! $end;
    return $end.chars   if ! $start;

    # special case: strings are the same
    return 0 if $start.lc ~~ $end.lc;


    # use a bootstrap character so that the
    # distance-matrix is always initialized with a
    # <none> operation
    my @start-chars = 'X', |$start.comb;
    my @end-chars   = 'X', |$end.comb;


    my @distance-matrix;
    @distance-matrix[ $_; 0 ] = $_ for ^@start-chars.end;
    @distance-matrix[ 0; $_ ] = $_ for ^@end-chars.end;




    for  ^@start-chars.end X ^@end-chars.end -> ( $i, $j ) {
        next if $i == 0 || $j == 0;

        @distance-matrix[ $i; $j ] =
                  @start-chars[ $i ] ~~ @end-chars[ $j ]
        ?? @distance-matrix[ $i - 1; $j - 1 ]   # no operation, keep the previous computation
        !!
        1 +   # add a cost of 'one' operation
        min (
            @distance-matrix[ $i - 1; $j ]   # insert
            , @distance-matrix[ $i; $j - 1 ] # delete
            , @distance-matrix[ $i - 1; $j - 1 ]  # substitute
        );
    }


    # the last computation contains the distance
    return @distance-matrix[ *-1; *-1 ];

}


sub MAIN( Str $S1 = 'kitten', Str $S2 = 'sitting' ){
    "Computing distance between '$S1' and '$S2' ==> %d".sprintf( distance($S1, $S2) ).say;
}

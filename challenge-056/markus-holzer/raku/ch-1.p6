sub MAIN( UInt $k, *@N )
{
    CATCH { say $*USAGE() and exit -1; }

    .say for ( @N>>.UInt )
        .pairs
        .combinations(2)
        .grep( -> $tupel { $tupel[1].value - $tupel[0].value == $k } )
        .map(  -> $tupel { $tupel>>.key } )
    ;
}

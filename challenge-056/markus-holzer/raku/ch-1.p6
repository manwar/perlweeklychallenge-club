sub MAIN( UInt $k, *@N )
{
    CATCH { say $*USAGE() and exit -1; }

    .say for ( @N>>.UInt )
        .pairs
        .combinations(2)
        .grep({ .[1].value - .[0].value == $k })
        .map( *>>.key );
}

sub MAIN( UInt $k, *@N )
{
    CATCH { say $*USAGE() and exit -1; }

    .say for ( @N>>.UInt )
        .pairs
        .combinations(2)
        .grep( abs( [-] *>>.value ) == $k )
        .map( *>>.key );
}

sub MAIN( UInt $k, *@N )
{
    CATCH { say $*USAGE() and exit -1; }

    .say for ( @N>>.UInt )
        .pairs
        .rotor( 2 => -1 )
        .grep({ .[1].value - .[0].value == $k })
        .map( *>>.key );
}

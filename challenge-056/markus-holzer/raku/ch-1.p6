sub USAGE() {
    print Q:c:to/EOH/;
            ch-2.p6 <k> <N1> <N2> <N3> ... <Nn>

        Example:
            ch-1.p6 2 2 4 6 7 9
    EOH
}

sub MAIN( UInt $k, *@N where *.elems > 1 )
{
    CATCH { USAGE() and exit -1; }

    .say for ( @N>>.UInt )
        .pairs
        .combinations( 2 )
        .grep({ .[1].value - .[0].value == $k })
        .map( *>>.key );
}

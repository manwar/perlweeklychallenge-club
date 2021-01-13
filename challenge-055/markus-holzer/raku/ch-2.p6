use Listlike::Utils;

sub USAGE() {
    print Q:c:to/EOH/;
        ch-2.p6 <n1> <n2> <n3> ... <nn>

        Example:
            ch-2.p6 1 2 3 4
    EOH
}

sub MAIN( *@input where *.elems > 1 )
{
    CATCH { USAGE() and exit -1; }

    ( @input>>.Int ).permutations
        .grep( &is-wavy )
        .do( &say );
}

sub is-wavy( @n ) returns Bool
{
    my $idx = 0;
    my @cmp = ( * <= * ),
              ( * >= * );

    # I'm using the all - method of my Listlike::Utils module
    # for the sake of clarity: # .all(...) vs. not so .first(...)
    @n  .rotor( 2 => -1 )
        .all({ &@cmp[ $idx = $idx +^ 1 ]( |$_ ) });
}
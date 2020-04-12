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

    .say for ( @input>>.Int )
        .permutations
        .grep: &is-wavy;
}

sub is-wavy( @n ) returns Bool
{
    my $idx = 0;
    my @cmp = ( * <= * ),
              ( * >= * );

    not so @n
        .rotor( 2 => -1 )
        .first({
            not @cmp[ $idx = $idx +^ 1 ]( |$_ );
        });
}
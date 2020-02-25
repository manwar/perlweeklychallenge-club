sub MAIN( $n )
{
    # I have no formal proof for this, but I have a strong hunch that it's true.
    say "Impossible" and exit 
        if so ( 2, 4, 8 ... *² > $n ).first( $n %% * );

    say (1, 10, { $_ %% 2 ?? $_ + 1 !! $_ * 10 } ... *).first( * %% $n );
}

#!raku

sub MAIN( Str $S, Str $T ) {
    my $counter = 0;
    my $regexp = $T.comb.join( '.*' );

    # overlapping search
    given $S {
        for m:exhaustive/ <$regexp> / -> $match {
            $counter++;
        }
    }

    say $counter;
}

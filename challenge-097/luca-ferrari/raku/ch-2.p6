#!raku


sub MAIN( Str $B = "101100101",
          Int $S = 3 ) {

    my @splits = $B.comb: $S.Int;
    my $flips = 0;

    my ( $a, $b ) = @splits[ 0 ], Nil;

    for 1 ..^ @splits.elems  {
        $b = @splits[ $_ ];

        # find out how many chars are different
        $flips++ if ( $a.comb[ $_ ] != $b.comb[ $_ ] ) for ^@$a.comb.elems;
    }

    say $flips;
}

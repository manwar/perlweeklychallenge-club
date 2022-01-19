#!raku

multi sub is-cardano-triplet( $a, $b, $c ) {

    my $left  = .sign * .abs**( 1 / 3 ) given ( $a + $b * $c.sqrt );
    my $right = .sign * .abs**( 1 / 3 ) given ( $a - $b * $c.sqrt );
    return 1 =~= ( $left + $right );
}


multi sub is-cardano-triplet( @triplet ) {
    return is-cardano-triplet( @triplet[ 0 ], @triplet[ 1 ], @triplet[ 2 ] );
}

sub MAIN( Int $limit = 5 ) {
    my @triplets = lazy gather {
        for 1 .. Inf -> $a {
            for 1 ..^ $a -> $b {
                for 1 ..^ $b -> $c {
                    $_.take if is-cardano-triplet( $_ ) for ( $a, $b, $c ).permutations;

                }
            }
        }
    };

    @triplets[ 0 .. $limit ].join( "\n" ).say;
}

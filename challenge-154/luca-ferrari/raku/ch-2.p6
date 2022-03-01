#!raku

sub MAIN( Int $limit where { $limit > 0 } = 10 ) {

    my @padovan-numbers = lazy gather {
        for 0 .. Inf {
            # initial values
            take 1 if $_ == any( 0, 1, 2 );
            take @padovan-numbers[ $_ - 3 .. $_ - 2 ].sum if $_ > 2;
        }
    };

    my $current-index = 0;
    my @unique-padovan-numbers;
    while ( @unique-padovan-numbers.elems <= $limit ) {
        my $current = @padovan-numbers[ $current-index ];
        while ( @unique-padovan-numbers.grep( $current ) || ! $current.is-prime ) {
            $current = @padovan-numbers[ ++$current-index ];
        }

        @unique-padovan-numbers.push: $current;
    }

    @unique-padovan-numbers[ 0 .. $limit ].join( ', ' ).say;
}

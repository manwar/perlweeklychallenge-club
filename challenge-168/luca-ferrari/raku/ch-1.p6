#!raku

# Perl Weekly Challenge 168

sub MAIN( Int $limit where { $limit > 1 } = 13 ) {

    # this requires too much time!
    # my @perrin = 3, 0, 2, -> $left, $right { $left + $right } ... *;
    # my @perrin-primes = @perrin.grep( *.is-prime );
    # @perrin-primes.unique.head( 3 ).join( "\n" ).say;

    my @perrin = 3, 0, 2;
    my @perrin-primes;

    while ( @perrin-primes.elems < $limit ) {
        @perrin.push: @perrin[ * - 2 ] + @perrin[ * - 3 ];
        @perrin-primes.push: @perrin[ * - 1 ] if @perrin[ * - 1 ].is-prime && ! @perrin-primes.grep( @perrin[ * - 1 ] );
    }

    @perrin-primes.sort.join( "\n" ).say;
}

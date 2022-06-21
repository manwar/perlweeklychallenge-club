#!raku

# Perl Weekly Challenge 170

sub MAIN( Int $limit = 10 ) {

    my @primes;
    my @primordial = lazy gather {
        for ( 1 .. Inf ) {
            next if ! .is-prime;
            @primes.push: $_;
            take [*] @primes;
        }
    };

    @primordial[ 0 .. $limit ].join( "\n" ).say;
}

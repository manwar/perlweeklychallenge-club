#!raku

sub MAIN( Int $limit where { $limit > 1 } = 100 ) {
    my @semi-primes;

    for 1 .. $limit -> $current-number {
        @semi-primes.push: $current-number if ( 1 .. $current-number ).grep( { $_.is-prime
                                                                               && $current-number %% $_
                                                                               && ( $current-number / $_ ).Int.is-prime } )
                            .elems > 0;
        # for 1 .. $current-number -> $current-divisor {
        #     next if ! $current-divisor.is-prime;
        #     next if   $current-number !%% $current-divisor;
        #     next if ! ( $current-number / $current-divisor ).Int.is-prime;
        #     @semi-primes.push: $current-number;
        #     last;
        # }
    }

    @semi-primes.join( ',' ).say;
}

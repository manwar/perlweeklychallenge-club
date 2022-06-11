#!raku

sub MAIN( Int $limit  where { $limit > 0 } = 1000 ) {
    my @cuban-primes = lazy gather {
        for ( 1 .. Inf ) {
            my $cuban = ( $_ + 1 ) ** 3 - $_ ** 3;
            last if $cuban > $limit;
            take $cuban if $cuban.is-prime;
        }
    };

    @cuban-primes.join( ', ' ).say;
}

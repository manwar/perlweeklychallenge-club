#!raku

sub MAIN( Int $which where { $which > 0 } = 1001 ) {
    my @primes = lazy { ( 1 .. Inf ).grep( *.is-prime ); }
    @primes[ $which ].say;
}

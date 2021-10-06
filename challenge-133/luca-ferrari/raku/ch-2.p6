#!raku

my @PRIMES = grep {.is-prime}, 1..*;

multi do-factor( 1 ) { (1) }
multi do-factor( Int $n where { $n > 1 } ) {
    my ( $pos, $needle ) = 0, $n;

    my @factors;

    for @PRIMES -> $current-factor {
        last if $current-factor > $needle;
        next unless $needle %% $current-factor;

        # if here, it is a good factor
        @factors.push: $current-factor;

        $needle /= $current-factor;
    }

    
    @factors;
    

}



sub is-smith-number( Int $n where { $n > 0 } ) {
    return $n.comb.sum == do-factor( $n ).sum;
}


sub MAIN( Int $limit where { $limit > 0 } = 10 ) {

    my @smith-numbers;
    for 1 .. Inf {
        next if ! is-smith-number( $_ );
        @smith-numbers.push: $_;
        last if @smith-numbers.elems == $limit;
    }

    @smith-numbers.join( "\n" ).say;
}

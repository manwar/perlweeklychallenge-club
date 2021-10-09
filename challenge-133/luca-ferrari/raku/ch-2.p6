#!raku

# a lazy list of all prime numbers
my @PRIMES = grep {.is-prime}, 1..*;

# divide a number into a list of its own factors
multi do-factor( 1 ) { (1) }
multi do-factor( Int $n where { $n > 1 } ) {
    my $needle =  $n;
    my @factors;

    for @PRIMES -> $current-factor {
        # stop if we got a bigger number
        last if $current-factor > $needle;

        # skip if the number is not a divisor of what we are searching for
        next unless $needle %% $current-factor;

        # if here, it is a good factor
        @factors.push: $current-factor;

        # compute the remainder
        $needle /= $current-factor;
    }

    
    @factors.sort;
    

}


# It is a smith number if the sum of the digits
# is the sum of the factors
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

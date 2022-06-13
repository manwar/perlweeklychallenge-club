#!raku

# Perl Weekly Challenge 169

sub compute-factors( $num ) {
    my $number = $num;
    my @factors;

    for 2  ..^ $number {
        next if ! $_.is-prime;

        while ( $number %% $_ ) {
            @factors.push: $_;
            $number /= $_;
        }
    }

    return @factors;
}


sub is-achille( $num )
{
    my Bag $bag = Bag.new: compute-factors( $num );
    return False if $bag.keys.elems <= 1;
    return $bag.values.min >= 2 && ( [gcd] $bag.values ) == 1;
}

sub MAIN( Int $limit where { $limit > 0 } = 20 ) {

    my @achille = lazy gather {
      take $_ if is-achille( $_ ) for 1 .. Inf;
    };

    @achille[ 0 .. $limit ].join( "\n" ).say;

}

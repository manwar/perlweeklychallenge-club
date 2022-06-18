#!raku

# Perl Weekly Challenge 169

sub is-brilliant( $num ) {
    my $number = $num;

    # get all the factors
    my @factors;

    for 2  ..^ $number {
        next if ! $_.is-prime;

        while ( $number %% $_ ) {
            @factors.push: $_;
            $number /= $_;
        }
    }

    return False if @factors.elems != 2;
    return False if @factors[0] == @factors[1];
    return True if @factors[0].Str.chars == @factors[1].Str.chars;
}


sub MAIN( Int $limit where { $limit > 0 } = 20 ) {

    my @brilliant = lazy gather {
      take $_ if is-brilliant( $_ ) for 1 .. Inf;
    };

    @brilliant[ 0 .. $limit ].join( "\n" ).say;

}

#!raku

# Perl Weekly Challenge 171

sub is-abundant( Int:D $n ) {
    my @divisors = 1;
    @divisors.push: $_ if $n %% $_ for ( 2 .. $n / 2 );
    return @divisors.sum > $n;
}

sub MAIN() {
    my @abundant = lazy gather {
      take $_ if $_ !%% 2 && is-abundant( $_ ) for ( 1 .. Inf );
    };

    @abundant[ 0 .. 20 ].join( "\n" ).say;
}

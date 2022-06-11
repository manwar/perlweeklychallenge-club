#!raku

sub MAIN( Int $limit where { $limit > 0 } = 10 ) {
    my @factorials = lazy gather {
        for 0 .. $limit {
            take 1 if $_ <= 1;
            take [*] 1 .. $_ if $_ > 1;
        }
    };

    my @numbers = lazy gather {
        for 0 .. $limit {
            take 0 if $_ == 0;
            take 1 if $_ == 1;
            take @factorials[ 0 .. $_ -1 ].sum if $_ > 1;
        }
    };

    @numbers[ 0 .. $limit ].join( "\n" ).say;
}

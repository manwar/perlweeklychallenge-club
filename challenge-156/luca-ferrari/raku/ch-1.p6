#!raku

sub MAIN( Int $limit where { $limit > 0 } = 10 ) {
    my @pernicious = lazy gather {
	for 1 .. Inf {
	    take $_ if $_.base( 2 ).comb.sum.is-prime;
	}
    };

    @pernicious[ 0 .. $limit - 1 ].join( ', ' ).say;
}

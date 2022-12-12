#!raku

# Perl Weekly Challenge 195

sub MAIN( Int $n where { $n > 0 }, Bool :$verbose = False ) {
    my @special-integers;
    for 1 .. $n {
	@special-integers.push: $_ if  $_.comb.Bag.values.max <= 1;
    }

    @special-integers.join( ',' ).say if ( $verbose );
    @special-integers.elems.say;
}

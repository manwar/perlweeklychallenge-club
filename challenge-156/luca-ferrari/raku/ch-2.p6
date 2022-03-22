#!raku

sub MAIN( Int $n where { $n > 0 } ) {
    my @divisors = ( 1 .. $n - 1 ).grep( $n %% * );
    '0'.say and exit if @divisors.sum <= $n
		     || @divisors.combinations.map( *.sum ).grep( * == $n ).elems > 0;
    '1'.say;
}

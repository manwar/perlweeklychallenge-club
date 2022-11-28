#!raku

# Perl Weekly Challenge 193

sub MAIN( Int $n where { $n > 0 } ) {

    my @bins = ( 0 .. 2 ** $n - 1 ).map( { sprintf "%b", $_ } ).map( { '0' x ( $n - $_.chars ) ~ $_ } );

    @bins.join( ', ' ).say;
}

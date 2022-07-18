#!/usr/bin/env raku

#= Generate Disarium Numbers (defaults to 19)
multi sub MAIN (
    UInt \n = 19 #= Number of Disarium Numbers to generate
) {
    .say for (1..*).race.grep( { is-disarium( $_ ) } )[^n];
}

multi sub MAIN( "TEST" ) is hidden-from-USAGE {
    use Test;
    ok( is-disarium( 518 ) );
    ok( ! is-disarium( 517 ) );
}

sub is-disarium( Int $n ) {
    $n ~~ [+] $n.comb.map( { state $c = 1;$_ ** $c++ } ); 
}

#!/usr/bin/env raku

#| Given a value $n return if it is an Esthetic Number                        
sub MAIN( UInt $n ) {
    say [==] 1, |( $n.comb().rotor( 2 => -1 ).map( { abs([-] @^a) } ) );
}

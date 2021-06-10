#!raku

sub MAIN( *@N where { @N.elems == @N.grep( * ~~ Int ).elems } ) {
    @N.sort.rotor( 2 => -1 ).map( { $_[ 1 ] - $_[ 0 ] } ).max.say;
}

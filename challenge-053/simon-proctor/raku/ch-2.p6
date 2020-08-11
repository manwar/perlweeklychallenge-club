#!/usr/bin/env raku

use v6;

#| Given a number between 1 and 5 return all the strings made of vowels following this rule :
#|   ‘a’ can only be followed by ‘e’ and ‘i’.
#|   ‘e’ can only be followed by ‘i’.
#|   ‘i’ can only be followed by ‘a’, ‘e’, ‘o’, and ‘u’.
#|   ‘o’ can only be followed by ‘a’ and ‘u’.
#|   ‘u’ can only be followed by ‘o’ and ‘e’.
sub MAIN (
    UInt $count where 1 <= * <= 5;
) {
    my @strings = ('');

    .say for process( @strings, $count );
}

multi sub process( @list, 0 ) is pure {
    @list;
}

multi sub process( @list, $count ) is pure {
    process( @list.map( { valid-next( $_ ) } ).flat, $count - 1 );
}

multi sub valid-next( '' ) is pure {
    <a e i o u>; 
}

sub append-val( $val, *@rest ) is pure {
    @rest.map( { $val ~ $_ } );
}

multi sub valid-next( Str $x where *.ends-with('a') ) is pure {
    append-val( $x, <e i> );
}

multi sub valid-next( Str $x where *.ends-with('e') ) is pure {
    append-val( $x, <i> );
}

multi sub valid-next( Str $x where *.ends-with('i') ) is pure {
    append-val( $x, <a e o u> );
}

multi sub valid-next( Str $x where *.ends-with('o') ) is pure {
    append-val( $x, <a u> );
}

multi sub valid-next( Str $x where *.ends-with('u') ) is pure {
    append-val( $x, <o e> );
}

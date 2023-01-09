#!raku

sub MAIN( Int $n where { $n > 0 } ) {
    (2 .. $n).grep( *.is-prime ).elems.say;
}

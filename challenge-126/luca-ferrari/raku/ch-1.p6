#!raku


sub MAIN( Int $N ) {
    ( 1 .. $N ).grep( * !~~ / 1 / ).elems.say;
}

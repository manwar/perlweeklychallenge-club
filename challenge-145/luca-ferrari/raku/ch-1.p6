#!raku

sub MAIN(  *@n where { @n.elems %% 2 && @n.grep( * ~~ Int ).elems == @n.elems } ) {
    ( [+] ( @n[ 0 .. @n.elems / 2 - 1 ] Z* @n[ @n.elems / 2 .. * - 1 ] ) ).say;
}

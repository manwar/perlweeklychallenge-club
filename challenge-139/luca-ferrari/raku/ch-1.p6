#!raku

sub MAIN(  *@n where { @n.elems > 0  && @n.grep( * ~~ Int ).elems == @n.elems } ) {
    '1'.say and exit if @n ~~ @n.sort;
    '0'.say;
}

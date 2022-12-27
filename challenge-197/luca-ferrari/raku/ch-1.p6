#!raku

# Perl Weekly Challenge 197

sub MAIN( *@list where { @list.grep( * ~~ Int ).elems == @list.elems } ) {
    my ( @swapped );
    @swapped = | @list.grep( * !~~ 0 ), | @list.grep( * ~~ 0 );
    @swapped.join( ',' ).say;
}

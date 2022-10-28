#!raku

sub MAIN( Bool :$verbose = False, Int :$k, *@list where { @list.elems == @list.grep( * ~~ Int ).elems } ) {
    my @pairs;
    for 0 ..^ @list.elems -> $i {
        for $i ^..^ @list.elems -> $j {
            @pairs.push: [ @list[ $i ], @list[ $j ] ] if ( ( @list[ $i ] + @list[ $j ] ) %% $k );
        }
    }

    @pairs.join( "\n" ).say if ( $verbose );
    @pairs.elems.say;
}

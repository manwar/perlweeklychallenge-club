#!raku

# Perl Weekly Challenge 199

sub MAIN( Bool :$verbose = False,
	*@list where { @list.grep( * ~~ Int ).elems == @list.elems } ) {
    my @pair-indexes;
    for 0 ..^ @list.elems - 1 -> $i {
	for $i + 1 ..^ @list.elems -> $j {
	    @pair-indexes.push: [ $i, $j, @list[ $i ], @list[ $j ] ] if @list[ $i ] == @list[ $j ];
	}
    }

    @pair-indexes.elems.say;
    @pair-indexes.map( { 'Idexes ' ~ $_[0] ~ ',' ~ $_[1] ~ ' refer to equal elements ' ~ $_[2] ~ ',' ~ $_[3] } ).join( "\n" ).say if $verbose;
}

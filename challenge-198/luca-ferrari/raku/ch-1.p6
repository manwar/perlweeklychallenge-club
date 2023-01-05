#!raku

sub MAIN( *@list where { @list.elems == @list.grep( * ~~ Int ).elems } ) {
    my @sorted = @list.sort;



    my %pairs;
    for 1 ..^ @sorted.elems - 1 {
	if ( ( @sorted[ $_ ] - @sorted[ $_ - 1 ] ) == ( @sorted[ $_ + 1 ] - @sorted[ $_ ] ) ) {
	    %pairs{ @sorted[ $_ ] - @sorted[ $_ - 1 ] }.push: @sorted[ $_ - 1, $_ ] , @sorted[ $_,  $_ + 1 ];
	}
    }


    %pairs{ %pairs.keys.max }.elems.say;

}

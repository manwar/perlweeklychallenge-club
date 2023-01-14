#!raku

# Perl Weekly Challenge 199

sub MAIN(
			   Int $x,
			   Int $y,
			   Int $z,
			   Bool :$verbose = False,
			   *@list where { @list.grep( * ~~ Int ).elems == @list.elems } ) {


# a) 0 <= i < j < k <= n (size of given array)
# b) abs(array[i] - array[j]) <= x
# c) abs(array[j] - array[k]) <= y
# d) abs(array[i] - array[k]) <= z

    my @triplets;
    for 0 ..^ @list.elems -> $i {
	for $i ^..^@list.elems -> $j {
	    for $j ^..^ @list.elems -> $k {
		@triplets.push: [ $i, $j, $k, @list[ $i ], @list[ $j ], @list[ $k ] ]
				    if ( ( @list[ $i ] - @list[ $j ] ).abs <= $x
					&& ( @list[ $j ] - @list[ $k ] ).abs <= $y
					&& ( @list[ $i ] - @list[ $k ] ).abs <= $z );

	    }
	}
    }

    @triplets.elems.say;
    @triplets.map( { "Indexes $_[0], $_[1], $_[2] are good ($_[3], $_[4], $_[5])" } ).join( "\n" ).say;
}

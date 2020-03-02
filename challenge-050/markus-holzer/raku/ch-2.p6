sub noble( @n ) 
{
	my Int $n = (@n = @n.sort).elems; 

	( 0..^$n )
		.grep({ 
			@n[ $^i ] == $n - $^i - 1 })
		.map({ 
			@n[ $^i ] });
}

say noble( [2, 4, 0, 3] );
say noble( [1, 4, 5, 6, 7, 8] );
say noble( [2, 2, 0, 3] );
say noble( [-1, 0] );

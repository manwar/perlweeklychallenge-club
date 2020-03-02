sub noble( @n ) 
{
	@n.sort.kv.batch(2).grep({ .[1] == @n.end - .[0] }).map({ .[1] });
}

say noble( [2, 4, 0, 3] );
say noble( [1, 4, 5, 6, 7, 8] );
say noble( [2, 2, 0, 3] );
say noble( [-1, 0] );
say noble( (1..60).roll(120).Array );

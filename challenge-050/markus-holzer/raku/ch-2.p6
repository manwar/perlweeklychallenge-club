sub noble( @n ) 
{
	( $_ = @n.sort.kv.batch(2).grep({ .[1] == @n.end - .[0] }).first ) ?? $_[1] !! Nil;
}

say noble( [2, 4, 0, 3] );
say noble( [1, 4, 5, 6, 7, 8] );
say noble( [2, 2, 0, 3] );
say noble( [-1, 0] );
say noble( (1..60).roll(120).Array );

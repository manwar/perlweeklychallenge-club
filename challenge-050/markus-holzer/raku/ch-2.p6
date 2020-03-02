sub noble( @n ) 
{
	my $n = ( @n = @n.sort ).end; 
	my $i = ( 0..$n ).first({ @n[ $^i ] == $n - $^i });
	try @n[ $i ]; # $i can be Nil
}

say noble( [2, 4, 0, 3] );
say noble( [1, 4, 5, 6, 7, 8] );
say noble( [2, 2, 0, 3] );
say noble( [-1, 0] );
say noble( (1..60).roll(120).Array );

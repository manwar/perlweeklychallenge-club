my @A = (7, 8, 3, 12, 10);

say join ' ', 0, gather for 1 .. +@A - 1 -> $i { 
	take .min with @A[ 0..$i-1 ].grep( * < @A[$i] ) or 0 };

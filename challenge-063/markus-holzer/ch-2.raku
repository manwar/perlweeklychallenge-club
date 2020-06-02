say r('xyxx'); 

multi sub r( Str $orig ) 
{ 
	r $orig.comb.List
}

multi sub r( List $orig ) 
{ 
    my $work = $orig;

    for ( 1 .. Inf ).map( * % 4 ).kv -> $n, $by
    {
	$work = $work.rotate: $by;

	return $n + 1 
		if $work cmp $orig == Same;
    }
}
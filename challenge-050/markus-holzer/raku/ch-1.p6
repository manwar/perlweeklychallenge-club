sub merge( **@tupel )
{
	my $current = @tupel.first;
	
	gather 
	{
		for @tupel[ 1..* ] -> $next
		{
			$current = [ $current[0], $next[1] ] and next
				if $next[0] < $current[1];

			take $current;
			$current = $next;
		}

		take $current;
	}
}

dd merge( [2, 7], [3, 9], [10, 12], [15, 19], [18, 22] );
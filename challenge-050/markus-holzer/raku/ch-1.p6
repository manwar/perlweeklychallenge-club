sub merge-flat( *@values where @values.elems %% 2 )
{
	merge( |@values.batch(2) );
}

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
dd merge-flat( 2, 7, 6, 11, 10, 17, 15, 19, 18, 27 );
dd merge( [1, 2], [3, 4], [5, 6] );
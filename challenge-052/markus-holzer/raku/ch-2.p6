enum Player <Computer Human>;
subset Difficulty of Int where * ~~ 1|2|3;

sub USAGE {
	say q:to/USAGE/;
    Usage:
        ch-2.p6 <difficulty>

    Possible Difficulties: 1, 2, 3
    USAGE
}

sub MAIN( Difficulty $difficulty  )
{
	my @moneyz = (0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2).pick(8);
	my @player = (Computer, Human).pick(2);
	my %score;

	while @moneyz.elems
	{
		say "@player[0] Pick: {@moneyz}";
		%score{ @player[0] } += pick-best( @player[0], $difficulty, @moneyz );
		@player = @player.rotate(1);
	}

	say %score{Computer} > %score{Human}
		?? "The machine wins with { %score{Computer} } by { %score{Computer} - %score{Human} }"
		!! "Good job, you beat the machine with { %score{Human} } by { %score{Human} - %score{Computer} }";
}


multi sub pick-best( Human, $, @moneyz )
{
	my $side = prompt "Your turn (l/r): ";
	
	$side ~~ 'l'|'r' 
		?? pick( @moneyz, $side ~~ 'l' )
		!! pick-best( Human, $, @moneyz );
}

multi sub pick-best( Computer, 1, @moneyz )
{
	pick( @moneyz, (True, False).pick );
}

multi sub pick-best( Computer, 2, @moneyz )
{
	pick( @moneyz, @moneyz[0] > @moneyz[*-1] );
}

multi sub pick-best( Computer, 3, @moneyz )
{
	my $left  = @moneyz.first( * == 2, :k);

	# 2 not in the list anymore
	return pick-best( Computer, 2, @moneyz )
		unless $left.defined;

	my $right = @moneyz.elems - $left - 1;

	return pick(@moneyz, True)  if $left  == 0;
	return pick(@moneyz, False) if $right == 0;

	my $l = $left %% 2;
	my $r = $right %% 2;

	return pick(@moneyz, True)  if $l && !$r;
	return pick(@moneyz, False) if $r && !$l;

	return pick(@moneyz, $left > $right);
}

multi sub pick( @moneyz, Bool $left )
{
	$left ?? @moneyz.shift !! @moneyz.pop;
}
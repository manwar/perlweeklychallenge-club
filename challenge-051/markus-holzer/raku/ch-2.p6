use Terminal::ANSIColor;

sub MAIN( Int $from, Int $to, Bool :$only = False )
{

	print "$_, " for gather for $from..$to -> $n 
	{
		my $is-colorful = is-colorful( $n );
		take colorize( $n, $is-colorful ) 
			if $is-colorful or not $only;
	}
}


sub colorize( $n, $colorful )
{
	state @colors = <red green yellow blue magenta cyan>;
	my $color     = $colorful ?? @colors.pick !! 'white';
	color($color) ~ $n ~ color('reset');
}

sub is-colorful( $n )
{
	my @digits = $n.comb;

	# save some work
	return False 
		if ( @digits.repeated )
		or ( $n > 1 && '1' (elem) @digits );

	not consecutive-combinations( @digits )
		.map({ [*] $_ })
		.repeated
	;
}

sub consecutive-combinations( @n )
{
	my sub keys-of( @p )   { @p.map: *.key   }
	my sub values-of( @p ) { @p.map: *.value }

	my sub is-consecutive( @n ) { 
		not @n.rotor(2 => -1).first( -> ($a, $b) { $a + 1 != $b }) }

	@n
		.pairs
		.combinations(1..*)
		.grep({ is-consecutive( .&keys-of ) })
		.map({ .&values-of })
	;
}
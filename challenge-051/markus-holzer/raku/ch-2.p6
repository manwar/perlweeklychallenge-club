use Terminal::ANSIColor;

sub MAIN( Int $from, Int $to, Bool :$show-all = False )
{

	print join ', ', gather for $from..$to -> $n 
	{
		my $is-colorful = is-colorful( $n );
		take colorize( $n, $is-colorful ) 
			if $is-colorful or $show-all;
	}
}

sub colorize( $n, $colorful )
{
	state @colors = <red green yellow blue magenta cyan>;
	my $color     = $colorful ?? @colors.pick !! 'white';
	color( $color ) ~ $n ~ color( 'reset' );
}

sub is-colorful( $n )
{
	my @digits = $n.comb;

	# save some work
	return False 
		if ( @digits.repeated )
		or ( $n > 1 && '1' (elem) @digits );

	my sub product( @n ) { [*] @n };

	not consecutive-combinations( @digits )
		.map({ .&product })
		.repeated
	;
}

sub consecutive-combinations( @n )
{
	my sub keys( @p )   { @p.map: *.key   }
	my sub values( @p ) { @p.map: *.value }

#       Pretty, but adhoc mixins are terribly sloooooow
#	my sub infix:<++>($a, $b)    { $b but ($a + 1 == $b) }; 
#	my sub are-consecutive( @n ) { so [++] @n }; 

#       Too much work
#	my sub are-consecutive( @n ) { 
#		not @n.rotor( 2 => -1 ).first( -> ($a, $b) { $a + 1 != $b }) }

	my sub are-consecutive( @n ) { not ( 1..@n.end ).first({ 
		@n[ $_ ] - @n[ $_ - 1 ] != 1 }) }; 

	@n
		.pairs
		.combinations( 1..* )
		.grep({ .&keys.&are-consecutive })
		.map({ .&values })
	;
}
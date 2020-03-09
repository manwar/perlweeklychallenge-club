use Terminal::ANSIColor;

sub MAIN( Int $from, Int $to, Bool :$only = False )
{
	my @colors = <red green yellow blue magenta cyan>;

	print "$_," for gather for $from..$to -> $n
	{
		my @subsets  = consecutive-combinations( $n.comb );
		my @products = @subsets.map({ [*] $_ });
		my $colorful = @products.elems == @products.unique.elems;
		my $color    = $colorful ?? @colors.pick !! 'white';

		take color($color) ~ $n ~ color('reset')
			if $colorful or !$only; 
	};
}


sub consecutive-combinations( @n )
{
	my sub keys-of( @p )        { @p.map: *.key   }
	my sub values-of( @p )      { @p.map: *.value }

	my multi sub is-consecutive( $a, $b ) { $a + 1 == $b }
	my multi sub is-consecutive( @n )     { @n.elems == 1 or [[&is-consecutive]] @n }

	@n
		.pairs
		.combinations(1..*)
		.grep({ is-consecutive( .&keys-of ) })
		.map({ .&values-of })
	;
}





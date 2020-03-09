use Terminal::ANSIColor;
use Terminal::Table;

sub MAIN( Int $from, Int $to, Bool :$only = False )
{
	my @colors = <red green yellow blue magenta cyan>;

	print "$_, " for gather for $from..$to -> $n
	{
		my @subsets  = consecutive-combinations( $n.comb );
		my @products = @subsets.map({ [*] $_ });
		my $colorful = @products.elems == @products.unique.elems;
		my $color    = $colorful ?? @colors.pick !! 'white';

		take color($color) ~ $n ~ color('reset')
			if $colorful or !$only; 
	}
}


sub consecutive-combinations( @n )
{
	my sub keys-of( @p )   { @p.map: *.key   }
	my sub values-of( @p ) { @p.map: *.value }

	@n
		.pairs
		.combinations(1..*)
		.grep({ is-consecutive( .&keys-of ) })
		.map({ .&values-of })
	;
}

my sub is-consecutive( @n ) 
{ 
	@n.elems == 1 
		or 
	not @n.rotor(2 => -1).first({ .[0] + 1 == .[1] }) 
}




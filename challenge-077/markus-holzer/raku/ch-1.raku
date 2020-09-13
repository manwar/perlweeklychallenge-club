use experimental :cached;

unit sub MAIN( $N, $v = False );

my $start = now;

with gather combine( zeckendorf( $N ) )
{
	say "# of combinations: {.elems}";
	say "Calculated in { sprintf "%.3f", now - $start } seconds";
	if $v { .say for .sort( -*.elems ) }
}

sub combine( @Z is copy ) is cached
{
	take @Z;

	my &insert = { my @x = @Z.clone; @x[$^i] = $^z; [@x.map: |*] };
	my &valid  = { $^x.elems == $^x.unique.elems && @$^x !~~ @Z };

	sink @Z
		.map( &zeckendorf )
		.kv.map( &insert )
		.grep( &valid )
		.map( &combine );
}

sub zeckendorf( $n is copy ) is cached
{
	state @fib = [1, 1, * + * ... * > $N];

	$n == 1
		?? 1.List
		!! eager gather for @fib.grep( * < $n ).reverse
		{
			if $_ <= $n {
				take $_;
				$n -= $_;
			}
		}
}

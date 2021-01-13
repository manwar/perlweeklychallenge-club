#! /usr/bin/env rakudo

sub coin-combinations( Int :$sum, :@coins where .all > 0 )  {
	my @combinations = 1, |(0 xx $sum);

	for @coins -> $coin {
		loop (my $i = $coin; $i < @combinations.elems; ++$i) {
			@combinations[$i] += @combinations[$i - $coin];
		}
	}
	return @combinations.tail;
}

say coin-combinations :sum(6), :coins([1, 2, 4]);

# Test: perl6 ch-1.p6
our %found;

sub MAIN() {
	my @C = (1, 2, 4);
	my $S = 6;
	my @bag = ();
	coin-combinations(@C, $S, @bag);
	say "Output: " ~ %found.keys.elems ~ ' solutions';
}

sub coin-combinations(@C, $S, @bag is copy) {

	for (@C) -> $coin {
		@bag.push($coin);
		if (@bag.sum < $S) {
				coin-combinations(@C, $S, @bag);
		}

		if (@bag.sum == $S) {
			my $key = '(' ~ @bag.sort.join(',') ~ ')';
			say $key unless (%found{$key});
			%found{$key} = True;
		}

		@bag.pop;
	}
}

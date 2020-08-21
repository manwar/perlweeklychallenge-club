# Test: perl6 ch-2.p6
sub MAIN() {
	say smallest-neighbor((7, 8, 3, 12, 10));
	say smallest-neighbor((4, 6, 5));
}

sub smallest-neighbor(@A) {
	my @out;
	my $smallest_so_far;

	for (0 .. @A.elems - 1) -> $i {
		if ( defined($smallest_so_far) &&
		     @A[$i] > $smallest_so_far ) {
			@out.push($smallest_so_far);
		} else {
			@out.push(0);
		}
		
		$smallest_so_far = @A[$i]
			unless (defined($smallest_so_far));

		$smallest_so_far = @A[$i]
			if ($smallest_so_far > @A[$i]);
	}

	return '(' ~ @out.join(', ') ~ ')';
}

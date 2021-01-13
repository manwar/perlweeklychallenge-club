# Test: perl6 ch-2.p6
use Test;

sub MAIN() {
	is fnr('ababc'),  'abb#c', 'ababc';
	is fnr('xyzzyx'), 'xyzyx#', 'xyzzyx';
	done-testing();
}

sub fnr(Str $S) {
	my @S = $S.comb;
	my %counts;
	my $output;

	loop (my $i = 0; $i < @S.elems; $i++) {
		my $c = @S[$i]; #character
		my $fnr;

		# If this is the first time the
		# letter exists use it
		$fnr = $c
			if (not defined(%counts{$c}));

		# Increment counts
		%counts{$c}++;

		# Use the first non repeating
		# if there is no duplicate
		unless ($fnr) {
			loop (my $j = $i - 1; $j >= 0; $j--) {
				my $c2 = @S[$j];
				if ( defined(%counts{$c2}) &&
				     %counts{$c2} == 1 ) {
					$fnr = $c2;
					last;
				}
			}
		}

		# If we didn't find a possible
		# frn use a #
		$fnr = '#' unless ($fnr);

		$output ~= $fnr;
	}

	return $output
}

# Test: perl6 ch-1.p6
sub MAIN() {
	my @m1 = [ [1, 0, 1],
	           [1, 1, 1],
	           [1, 1, 1], ];

	my @m2 = [ [1, 0, 1],
	           [1, 1, 1],
	           [1, 0, 1], ];

	for (@m1, @m2) -> $m {
		say "Input:";
		print-matrix($m);

		say "Output:";
		print-matrix(zero($m));
	}
}

# Zero our columns and rows
sub zero(@m) {
	# Initialize new matrix
	my $m2 = [];
	for (^@m) -> $i {
		$m2.[$i] = [];
		for (^@m.[0]) -> $j {
			$m2.[$i][$j] = 1;
		}
	}

	# Process each element of the matrix
	for (^@m) -> $i {
		for (^@m.[0]) -> $j {
			if (@m.[$i][$j] == 0) {
				# zero our rows
				for (^@m) -> $k {
					$m2.[$k][$j] = 0;
				}

				# zero out cols
				for (^@m.[0]) -> $k {
					$m2.[$i][$k] = 0;
				}
			}
		}
	}

	# Return new matrix
	return $m2;
}

# Print the matrix
sub print-matrix(@m) {
	my $l1 = @m.elems;
	my $l2 = @m.[0].elems;

	# Process each element of the matrix
	for (^@m) -> $i {
		print '[ ';
		for (^@m.[0]) -> $j  {
			'%3s'.printf(@m.[$i][$j].perl);
		}
		say ' ]';
	}

	say '';
}

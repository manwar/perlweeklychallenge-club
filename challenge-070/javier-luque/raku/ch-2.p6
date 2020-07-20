# Test: perl6 ch-2.p6
sub MAIN() {
	say gray-code(4);
}

sub gray-code(Int $N is copy where $N >= 2 && $N <=5 ) {
	my @S1 = ('00','01','11','10');

	while ($N > 2) {
		# Flip the array
		my @S2 = @S1.reverse;

		# Prefix
		@S1 = @S1.map({ '0' ~ $_ });
		@S2 = @S2.map({ '1' ~ $_ });

		# Concatenate
		@S1 = flat @S1, @S2;

		$N--;
	}

	# Convert to decimal
	@S1 = @S1.map({ "0b$_".Int });

	return @S1.perl;
}

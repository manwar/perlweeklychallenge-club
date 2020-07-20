#!/usr/bin/perl
# Test: ./ch-2.pl
use Modern::Perl;

say gray_code(4);

sub gray_code {
	my $N = shift;
	my @S1 = ('00','01','11','10');

	while ($N > 2) {
		# Flip the array
		my @S2 = reverse @S1;

		# Prefix
		@S1 = map { '0' . $_ } @S1;
		@S2 = map { '1' . $_ } @S2;

		# Concatenate
		push @S1, @S2;

		$N--;
	}

	# Convert to decimal
	@S1 = map { oct("0b" . $_) } @S1;

	return '[' . (join ', ', @S1) . ']';
}

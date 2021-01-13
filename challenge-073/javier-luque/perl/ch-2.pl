#!/usr/bin/perl
# Test: ./ch-2.pl
use Modern::Perl;

say smallest_neighbor(7, 8, 3, 12, 10);
say smallest_neighbor(4, 6, 5);

sub smallest_neighbor {
	my @A = @_;
	my @out;
	my $smallest_so_far;

	for my $i (0 .. scalar(@A) - 1) {
		if ( defined($smallest_so_far) &&
		     $A[$i] > $smallest_so_far ) {
			push @out, $smallest_so_far;
		} else {
			push @out, 0;
		}

		$smallest_so_far = $A[$i]
			unless (defined($smallest_so_far));

		$smallest_so_far = $A[$i]
			if ($smallest_so_far > $A[$i]);
	}

	return '(' . (join ', ', @out) . ')';
}

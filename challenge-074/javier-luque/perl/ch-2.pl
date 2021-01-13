#!/usr/bin/perl
# Test: ./ch-2.pl
use Modern::Perl;
use Test::More;

is fnr('ababc'),  'abb#c', 'ababc';
is fnr('xyzzyx'), 'xyzyx#', 'xyzzyx';
done_testing;

sub fnr {
	my @S = split('', shift);
	my %counts;
	my $output;

	for (my $i = 0; $i < scalar(@S); $i++) {
		my $c = $S[$i]; #character
		my $fnr;

		# If this is the first time the
		# letter exists use it
		$fnr = $c
			if (not defined($counts{$c}));

		# Increment counts
		$counts{$c}++;

		# Use the first non repeating
		# if there is no duplicate
		unless ($fnr) {
			for (my $j = $i - 1; $j >= 0; $j--) {
				my $c2 = $S[$j];
				if ( defined($counts{$c2}) &&
				     $counts{$c2} == 1 ) {
					$fnr = $c2;
					last;
				}
			}
		}

		# If we didn't find a possible
		# frn use a #
		$fnr = '#' unless($fnr);

		$output .= $fnr;
	}

	return $output
}

#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my @sets = (
	# given set
	['[2,7]', '[3,9]', '[10,12]', '[15,19]', '[18,22]'],

	# given set in reverse
	['[18,22]', '[15,19]', '[10,12]', '[3,9]', '[2,7]'],

	# out of order, overlapping lo vals, negatives
	['[1,9]', '[8,12]', '[15,23]', '[1,8]', '[-9,-3]'],

	# out of order, negatives, zero val
	['[9,3]', '[4,12]', '[0,99]', '[-3,-1]'],

	# just one set
	['[0,1]']
	);

merge($_) foreach @sets;

sub merge {
	my $set = shift;
	say "-"x25;
	say "@$set is the given set. \n";

	# remove all brackets and commas
	my @ints = "@$set" =~ /(-?\d+)/g;

	my %no_same_lo;
	while (@ints) {
		# process in pairs
		my $lo = shift @ints;
		my $hi = shift @ints;

		# what if interval was [hi,lo] by accident?
		($lo, $hi) = ($hi, $lo) if $lo > $hi;

		# what if multiple intervals have the same lo?
		# we only care about the highest hi val here
		$no_same_lo{$lo} = $hi
			unless defined($no_same_lo{$lo} && $no_same_lo{$lo} <= $hi);
	}

	# what if given intervals weren't in order?
	foreach my $lo (sort {$a <=> $b} keys %no_same_lo) {
		push @ints, ($lo, $no_same_lo{$lo});
	}

	# now we're sorted, removed duplicate lows, and fixed transpositions
	# if there's only one set [x,y] we're done
	# given [x,y], [z,w]: if y > z we can merge, if not move on

	my @merged;
	my ($lo, $hi);
	while (scalar @ints) {
		# pull next 2 values
		$lo = shift @ints;
		$hi = shift @ints;

		# only compare if there's more in the array
		if (scalar @ints) {
			# grab another 2 values
			my $nextlo = shift @ints;
			my $nexthi = shift @ints;
			say "[$lo,$hi] -> [$nextlo,$nexthi]";

			if ($hi >= $nextlo) {
				# we can merge
				# but check the two hi values first
				$nexthi = $hi if $hi > $nexthi;
				say "[$lo,$nexthi] is the NEW merged interval.";

				# put new set back into the front of the array
				unshift @ints, ($lo, $nexthi);
				$hi = $nexthi;

			} else {
				# can't merge, add to final set
				say "[$lo, $hi] can't be merged. Moving to final set.\n";
				push @merged, "[$lo,$hi]";

				# but put set back into the array
				unshift @ints, ($nextlo, $nexthi);
			}
		} else {
			# we're done here
			say "[$lo,$hi] is the last pair. Moving to final set.\n";
			push @merged, "[$lo,$hi]";
		}
	}

	say "@merged is the merged set. \n";
}
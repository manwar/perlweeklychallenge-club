#!/usr/bin/perl

use Test2::V0;
use List::Util qw(any min);

# Assemble given sum (1st arg) from a set of coins having values as
# specified in the remaining arguments.
sub assemble;
sub assemble {
	my ($sum, @coins) = @_;

	# There is no solution if the sum is less than the smallest coin.
	return if $sum < min @coins;

	# If a coin matches the given sum, this gives one (non-recursive)
	# assembly.
	((any {$sum == $_} @coins) ? [$sum] : (),
	# Try each coin for further assemblies.	
	map {
		my $coin = $_;
		# Reduce the sum by the selected coin and combine that one with
		# all possible assemblies of the reduced sum using solely coins
		# that are not smaller than the selected.
		map [$coin, @$_], assemble $sum - $coin, grep $_ >= $coin, @coins;
	} @coins);
}

is [assemble 6, 1, 2, 4],
	bag {
		item([1, 1, 1, 1, 1, 1]),
		item([1, 1, 1, 1, 2]),
		item([1, 1, 2, 2]),
		item([1, 1, 4]),
		item([2, 2, 2]),
		item([2, 4]),
		end()
	}, 'example from challenge';

done_testing;

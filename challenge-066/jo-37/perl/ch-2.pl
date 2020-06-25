#!/usr/bin/perl

use Test2::V0;

# Calculate integer logarithm of $num to $base.
# Return undef if the log is not an integer.
# $num and $base must both be larger then one and are not checked.
sub intlog {
	my ($num, $base) = @_;

	my $exp;
	for (; $num % $base == 0; $num /= $base) {
		$exp++;
	}

	$num == 1 ? $exp : undef;
}

# Return all pairs ($base, $exponent) where $num == $base ** $exponent.
sub powers {
	my $num = shift;

	map {my $exp = intlog $num, $_; $exp ? [$_, $exp] : ()} (2 .. sqrt $num);
}

sub print_powers {
	print +(join ' ', map {join('^', @$_)} powers shift) || 0, "\n";
}

# Test challenge examples.
is [powers 9], [[3, 2]], 'example 1';
is powers(45), 0, 'example 2';
is [powers 64], [[2, 6], [4, 3], [8, 2]], 'example 3';

done_testing;

# Print challenge examples.
print("$_:\t"), print_powers($_) foreach (9, 45, 64);

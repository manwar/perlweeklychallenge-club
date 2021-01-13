use v5.24;
use warnings;
use List::Util qw(first);

sub funky_division
{
	my ($am, $an) = map abs, my ($m, $n) = @_;
	my $is_negative = (($m != $am) xor ($n != $an));

	my @mul_map = (0); # zero is always zero
	while ($mul_map[-1] <= $am) {
		push @mul_map, $mul_map[-1] + $an;
	}

	my $result = first { $mul_map[$_] <= $am }
		reverse keys @mul_map;

	return $is_negative ? -$result : $result;
}

use Test::More;

my @data = (
	[[5, 2], 2],
	[[-5, 2], -2],
	[[5, -2], -2],
	[[-5, -2], 2],
	[[2, 5], 0],
	[[1900, 160], 11],
);

for (@data) {
	my ($case, $output) = @$_;
	is(funky_division(@$case), $output);
}

done_testing;

use v5.24;
use warnings;
use List::Util qw(min sum);

sub digits_sum
{
	my ($digits, $sum) = @_;

	my $min = 1 . (0 x ($digits - 1));
	my $max = min($sum, 9) x $digits;

	return [
		grep { sum(split //, $_) eq $sum }
		$min .. $max
	];

}

use Test::More;

my @data = (
	[[1, 7], [7]],
	[[1, 10], []],
	[[2, 4], [qw(13 22 31 40)]],
	[[2, 10], [qw(19 28 37 46 55 64 73 82 91)]],
	[[3, 3], [qw(102 111 120 201 210 300)]],
);

for (@data) {
	my ($case, $output) = @$_;
	is_deeply(digits_sum(@$case), $output);
}

done_testing;

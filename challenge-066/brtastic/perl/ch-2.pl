use v5.24;
use warnings;
use utf8;

my @superscripts = qw(
	⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹
);

sub power_integer
{
	my ($int) = @_;

	my @solutions;
	for my $base (2 .. sqrt($int)) {
		if ($int % $base == 0) {
			my $power = 2;
			while ($base ** $power < $int) {
				$power += 1;
			}

			if ($base ** $power == $int) {
				my $unicode_power = join "", map {
					$superscripts[$_]
				} split //, $power;

				push @solutions, "$base$unicode_power";
			}
		}
	}

	return \@solutions;
}

use Test::More;

my @data = (
	[65536, [qw(2¹⁶ 4⁸ 16⁴ 256²)]],
	[2048, [qw(2¹¹)]],
	[243, [qw(3⁵)]],
	[16, [qw(2⁴ 4²)]],
	[15, []],
	[12, []],
	[9, [qw(3²)]],
	[8, [qw(2³)]],
	[4, [qw(2²)]],
	[1, []],
);

for (@data) {
	my ($case, $output) = @$_;
	is_deeply(power_integer($case), $output);
}

done_testing;

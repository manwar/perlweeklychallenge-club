use v5.32;
use warnings;

use feature qw(signatures);
no warnings qw(experimental::signatures);

use constant MIRRORED => {qw(
	6 9
	9 6
	0 0
	8 8
)};

my $tr_search = join "", keys MIRRORED->%*;
my $tr_replace = join "", values MIRRORED->%*;

sub is_strobogrammatic($number = $_) {
	my sub flip($string) {
		my $count;
		eval "\$count = \$string =~ tr/$tr_search/$tr_replace/";
		return $count == length $string ? scalar reverse $string : undef;
	}

	my $flipped = flip($number);
	return !!0 unless defined $flipped;
	return $number eq $flipped;
}

sub find_strobogrammatic_in_range($from, $to) {
	return [
		grep is_strobogrammatic,
		grep { /^[$tr_search]+$/ }
		$from .. $to
	];
}

use Test::More;

is_deeply find_strobogrammatic_in_range(50, 100), [69, 88, 96];
is_deeply find_strobogrammatic_in_range(0, 10), [0, 8];
is_deeply find_strobogrammatic_in_range(100, 1000), [609, 689, 808, 888, 906, 986];

done_testing;

use strict;
use warnings;

use feature 'say';

while((my $s = <DATA>)) {
	say "Solution: " . x($s);
}


sub x {
	my @ints = split /, /, shift;
	my $rounds = 0;

	my $min = get_min_bigger_than_zero(@ints);
	while($min > 0) {
		@ints = map { $_ > 0 ? $_ - $min : $_ } @ints;
		$min = get_min_bigger_than_zero(@ints);
		$rounds++;
	}

	return $rounds;
}

sub get_min_bigger_than_zero {
	my @pos_ints = grep { $_ > 0 } @_;
	return 0 if ! @pos_ints; # Only zeroes left
	my $min = shift @pos_ints;
	foreach(@pos_ints) {
		if($_ < $min) {
			$min = $_;
		}
	}
	return $min;
}

__DATA__
1, 5, 0, 3, 5
0
2, 1, 4, 0, 3

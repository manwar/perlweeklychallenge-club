#! /usr/bin/env rakudo
sub count-trailing-zeros(Int $n) {
	my $running = $n;
	my Int $count = 0;
	while ($running > 0) {
		if ($running %% 10) {
			$running /= 10;
			++$count;
		} else {
			last;
		}
	}
	return $count;
}

my $fac := lazy 1, { $^a * ++$ } ... *;

say count-trailing-zeros($fac[10]);
say count-trailing-zeros($fac[7]);
say count-trailing-zeros($fac[4]);

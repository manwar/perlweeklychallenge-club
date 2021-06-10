use v5.30;
use warnings;
use List::Util qw(sum0);

for my $num (1 .. 20) {
	say sum0 grep {
		$num % $_ == 0
	} 2 .. int($num / 2);
}

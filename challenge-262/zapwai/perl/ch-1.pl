use v5.38;
use List::Util qw( max );
my @ints = (-3, 1, 2, -1, 3, -2, 4);
say "Input: (" . join(", ", @ints) . ")";
my ($neg, $pos) = (0, 0);
for my $num (@ints) {
    if ($num < 0) {
	$neg = $num if ($neg > $num);
    } else {
	$pos = $num if ($pos < $num);
    }
}
my $ans = max(abs($neg), $pos);
say "Output: $ans";

use v5.38;
use List::Util qw(min);
my @ints = (1, 2, 3, 4, 5);
proc(@ints);
@ints = (5, 7, 1, 7);
proc(@ints);

sub proc(@ints) {
    say "Input: (@ints)";
    my $cnt = 0;
    for my $i (0 .. $#ints - 1) {
	for my $j ($i + 1 .. $#ints) {
	    $cnt++ if ($ints[$i] != $ints[$j] && (abs($ints[$i] - $ints[$j]) < min($ints[$i], $ints[$j])));
	}
    }
    say "Output: $cnt";
}

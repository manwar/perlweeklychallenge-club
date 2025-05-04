use v5.38;
use List::Util qw(max);
sub proc(@ints) {
    say "Input: @ints";
    my ($neg_count, $pos_count) = (0,0);
    for my $num (@ints) {
	$neg_count++ if ($num < 0);
	$pos_count++ if ($num > 0);
    }
    say "Output: ", max($neg_count, $pos_count);
}
my @ints = (-3, -2, -1, 1, 2, 3);
proc(@ints);
@ints = (-2, -1, 0, 0, 1);
proc(@ints);
@ints = (1,2,3,4);
proc(@ints);

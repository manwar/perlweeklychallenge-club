use v5.38;
use List::Util qw(min max sum);
sub proc(@ints) {
    say "Input: \@ints = @ints";
    my ($min,$max) = (min(@ints), max(@ints));
    my @l;
    for my $val (@ints) {
	if ($val != $min && $val != $max) {
	    push @l, $val;
	}
    }
    my $o = "";
    if (@l) {
	$o = sum(@l)/(scalar @l);
    }
    say "Output: $o";
}

my @ints = (8000, 5000, 6000, 2000, 3000, 7000);
proc(@ints);
@ints = (100_000, 80_000, 110_000, 90_000);
proc(@ints);
@ints = (2500, 2500, 2500, 2500);
proc(@ints);
@ints = (2000);
proc(@ints);
@ints = (1000, 2000, 3000, 4000, 5000, 6000);
proc(@ints);

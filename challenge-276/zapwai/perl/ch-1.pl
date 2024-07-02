use v5.38;
my @hours = (12, 12, 30, 24, 24);
proc(@hours);
@hours = (72, 48, 24, 5);
proc(@hours);
@hours = (12, 18, 24);
proc(@hours);

sub proc(@hours) {
    say "Input: @hours";
    my $tally = 0;
    for my $i (0 .. $#hours - 1) {
	for my $j ($i + 1 .. $#hours) {
	    my $sum = $hours[$i] + $hours[$j];
	    if ($sum % 24 == 0) {
		$tally++;
	    }
	}
    }
    say "Output: $tally";
}

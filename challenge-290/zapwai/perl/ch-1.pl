use v5.38;
sub proc(@ints) {
    say "Input: \@ints = (" . join(", ", @ints) . ")";
    my $ans = "false";
    for my $i (0 .. $#ints - 1) {
	for my $j ($i + 1 .. $#ints) {
	    if ($ints[$i] == 2 * $ints[$j] || $ints[$j] == 2 * $ints[$i]) {
		$ans = "true";
	    }
	}
    }
    say "Output: $ans";
}

my @ints = (6, 2, 3, 3);
proc(@ints);
@ints = (3, 1, 4, 13);
proc(@ints);
@ints = (2, 1, 4, 2);
proc(@ints);

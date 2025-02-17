use v5.38;

sub proc(@ints) {
    say "Input: \@ints = @ints";
    my $min = abs($ints[1] - $ints[0]);
    for my $i (0 .. $#ints - 1) {
	for my $j ($i + 1, $#ints) {
	    my $diff = abs($ints[$i] - $ints[$j]);
	    $min = $diff if ($diff < $min);
	}
    }
    say "Output: $min";
}

my @ints = (2, 8, 10, 11, 15);
proc(@ints);
@ints = (9, 4, 1, 7);
proc(@ints);

use v5.38;
my @ints = (2, 2, 3, 4);
proc(@ints);
@ints = (1, 2, 2, 3, 3, 3);
proc(@ints);
@ints = (1, 1, 1, 3);
proc(@ints);
sub proc(@ints) {
    say "Input: \@ints = @ints";
    my $lucky = -1;
    my $max = 0;
    for my $item (@ints) {
	if ($max < $item) {
	    $max = $item;
	}
    }
    my @freq = (0) x (1 + $max);
    for my $item (@ints) {
	$freq[$item]++;
    }
    for my $i (1 .. $#freq) {
	if ($i == $freq[$i]) {
	    $lucky = $i;
	}
    }
    say "Output: $lucky";
}

use v5.38;

sub is_peak($i, @ints) {
    my $fail = 0;
    for my $j (0 .. $i - 1) {
	if ($ints[$j] >= $ints[$j+1]) {
	    $fail = 1;
	    last;
	}
    }
    unless ($fail == 1) {
	for my $j ($i .. $#ints - 1) {
	    if ($ints[$j] <= $ints[$j+1]) {
		$fail = 1;
		last;
	    }
	}
    }
    return !($fail);
}

sub proc(@ints) {
    say "Input: @ints";
    my $o = (@ints >= 3) ? "true" : "false";
    my $flag = 0;
    for my $i ( 1 .. $#ints - 1 ) {
	$flag = 1 if (is_peak($i, @ints));
    }
    $o = "false" unless ($flag);
    say "Output: $o";
}

my @ints = (1, 2, 3, 4, 5);
proc(@ints);
@ints = (0, 2, 4, 6, 4, 2, 0);
proc(@ints);
@ints = (5, 4, 3, 2, 1);
proc(@ints);
@ints = (1, 3, 5, 5, 4, 2);
proc(@ints);
@ints = (1, 3, 2);
proc(@ints);

use v5.38;

sub proc(@ints) {
    say "Input: @ints";
    my $min = abs($ints[0] - $ints[1]);
    for my $i (0 .. $#ints - 1) {
	for my $j ($i + 1 .. $#ints) {
	    my $diff = abs($ints[$i] - $ints[$j]);
	    $min = $diff if ($diff < $min);
	}
    }
    my @list;
    for my $i (0 .. $#ints - 1) {
	for my $j ($i + 1 .. $#ints) {
	    if (abs($ints[$i] - $ints[$j]) == $min) {
		if ($ints[$i] < $ints[$j]) {
		    push @list, "($ints[$i],$ints[$j])";
		} else {
		    push @list, "($ints[$j],$ints[$i])";
		}
	    }
	}
    }
    say "Output: @list";
}

my @ints = (4,2,1,3);
proc(@ints);
@ints = (10, 100, 20, 30);
proc(@ints);
@ints = (-5, -2, 0, 3);
proc(@ints);
@ints = (8, 1, 15, 3);
proc(@ints);
@ints = (12, 5, 9, 1, 15);
proc(@ints);

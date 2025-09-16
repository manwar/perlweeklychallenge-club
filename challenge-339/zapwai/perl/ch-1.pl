use v5.38;
sub proc(@ints) {
    say "Input: @ints";

    my $max = 0;

    for my $i (0 .. $#ints - 1) {
	for my $j ($i + 1 .. $#ints) {
	    my $a = $ints[$i];
	    my $b = $ints[$j];

	    my $prod1 = $a*$b;
	    
	    my @left;
	    for my $k (0 .. $#ints) {
		push @left, $ints[$k] unless ($k == $i || $k == $j);
	    }

	    for my $I (0 .. $#left - 1) {
		for my $J ($I + 1 .. $#left) {
		    my $c = $left[$I];
		    my $d = $left[$J];
		    my $prod2 = $c*$d;

		    # If diff is max, set and continue
		    my $diff = $prod1 - $prod2;
		    if ($diff > $max) {
			$max = $diff;
		    }
		}
	    }
	}
    }

    say "Output: $max";
}

my @ints = (5,9,3,4,6);
proc(@ints);

@ints = (1,-2,3,-4);
proc(@ints);
@ints = (-3, -1, -2, -4);
proc(@ints);
@ints = (10, 2, 0, 5, 1);
proc(@ints);
@ints = (7,8,9,10,10);
proc(@ints);

use v5.38;

sub mad(@ints) {
    my $min = abs($ints[1] - $ints[0]);
    for my $i (0 .. $#ints - 1) {
	for my $j ($i + 1 .. $#ints) {
	    my $diff = abs($ints[$i] - $ints[$j]);
	    $min = $diff if ($min > $diff);
	}
    }
    my @out;
    for my $i (0 .. $#ints - 1) {
	for my $j ($i + 1 .. $#ints) {
	    my $diff = abs($ints[$i] - $ints[$j]);
	    if ($diff == $min) {
		if ($ints[$i] < $ints[$j]) {
		    push @out, [$ints[$i], $ints[$j]];
		} else {
		    push @out, [$ints[$j], $ints[$i]];
		}
	    }
	}
    }
    return @out;
}

sub proc(@ints) {
    say "Input: @ints";
    my @o = mad(@ints);
    print "Output: ";
    print "(". join(", ", @$_) . ") " for (@o);
    say "";
}

my @ints = (4,1,2,3);
proc(@ints);
@ints = (1,3,7,11,15);
proc(@ints);
@ints = (1,5,3,8);
proc(@ints);

use v5.38;
sub proc(@ints) {
    my ($max, $max2, $max_ind) = (0, 0, 0);
    for my $i (0 .. $#ints) {
	if ($max < $ints[$i]) {
	    $max2 = $max;
	    $max = $ints[$i];
	    $max_ind = $i;
	}
    }
    say "Input: \@ints = @ints";
    print "Output: ";
    if ($max >= 2*$max2) {
	say $max_ind;
    } else {
	say -1;
    }
}

my @ints = (2,4,1,0);
proc(@ints);
@ints = (1,2,3,4);
proc(@ints);

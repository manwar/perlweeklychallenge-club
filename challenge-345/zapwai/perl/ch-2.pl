use v5.38;

sub proc(@ints) {
    say "Input: \@ints = @ints";
    my @seen;
    my @ans;
    my $xlen = 0;
    my $xon = 0;		# a flag that -1 is seen
    for my $num (@ints) {
	if ($num == -1) {
	    if ($xon) {
		$xlen++;
	    } else {
		$xlen = 1;
		$xon = 1;
	    }
	    if ($xlen <= @seen) {
		push @ans, $seen[$xlen-1];
	    } else {
		push @ans, -1;
	    }
	} else {
	    unshift @seen, $num;
	    $xon = 0;    
	}
    }
    say "Output: @ans";
}

my @ints = (5,-1,-1);
proc(@ints);
@ints = (3, 7, -1, -1, -1);
proc(@ints);
@ints = (2, -1, 4, -1, -1);
proc(@ints);
@ints = (10, 20, -1, 30, -1, -1);
proc(@ints);
@ints = (-1, -1, 5, -1);
proc(@ints);

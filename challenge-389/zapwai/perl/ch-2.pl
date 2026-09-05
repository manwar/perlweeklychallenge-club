use v5.38;

# Return true if the entire array zig-zags
sub zags(@a) {
    return 1 if ($#a == 0);
    return 0 if ($a[0] == $a[1]);
    # If array begins by descending, negate it, then test
    my @t = @a;
    unless ($a[0] < $a[1]) {
	@t = map {-1*$_} @a;
    }
    for my $i (0 .. $#t - 1) {
	if ($i % 2 == 0) {
	    if ($t[$i] >= $t[$i+1]) {
		return 0;
	    }
	} else {
	    if ($t[$i] <= $t[$i+1]) {
		return 0;
	    }
	}
    }
    return 1;
}

sub proc(@nums) {
    say "Input: @nums";
    my $length = @nums;
    my @t = @nums;
    my $s = 0;			# starting index
    while (!zags(@t)) {
	if ($s < @nums - $length) {
	    $s++;
	    @t = @nums[$s .. $s + $length - 1];
	} else {
	    $length--;
	    $s = 0;
	    @t = @nums[$s .. $s + $length - 1];
	}
    }
    say "Output: $length";
}

my @nums = (9, 4, 2, 10, 7, 8, 8, 1, 9);
proc(@nums);
@nums = (1, 7, 4, 9, 2, 5);
proc(@nums);
@nums = (1, 2, 3, 4, 5);
proc(@nums);
@nums = (4,4,4);
proc(@nums);
@nums = (10, 20, 15, 12, 18);
proc(@nums);

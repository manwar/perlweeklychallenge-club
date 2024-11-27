use v5.38;

sub tally_left($index, @list) {
    my $sum = 0;
    for my $i (0 .. $index - 1) {
	$sum += $list[$i];
    }
    return $sum;
}

sub tally_right($index, @list) {
    my $sum = 0;
    for my $i ($index + 1 .. $#list) {
	$sum += $list[$i];
    }
    return $sum;
}

sub proc(@list) {
    say "Input: @list";
    my $ind = -1;
    if (tally_right(0, @list) == 0) {
	$ind = 0;
    } else {
	for my $i (1 .. $#list - 1) {
	    if (tally_left($i, @list) == tally_right($i, @list)) {
		$ind = $i;
	    }
	}
    }
    if ($ind == -1) {
	if (tally_left($#list, @list) == 0) {
	    $ind = $#list;
	}
    }
    say "Output: $ind";
}

my @ints = (2, 3, -1, 8, 4);proc(@ints);
@ints = (1, -1, 4);proc(@ints);
@ints = (2,5);proc(@ints);

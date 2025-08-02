use v5.38;
my $MAX_LENGTH = 20;
my @ints = (1, 2, 2, 4, 1, 5);
proc(@ints);
@ints = (1, 2, 3, 4, 5);
proc(@ints);

sub proc(@ints) {
    say "Input: @ints";
    my @nums;
    my @freq = (1) x $MAX_LENGTH;
    for my $item (@ints) {
	my $have = 0;
	for (@nums) {
	    if ($_ == $item) {
		$have++;
	    }
	}
	if ($have == 0) {
	    push @nums, $item;
	} else {
	    $freq[$item] = $have + 1;
	}
    }
    say "Output:";
    foreach my $i (0 .. $#freq) {
	if ($freq[$i] != 1) {
	    say "$i -> $freq[$i]";
	}
    }
    my @mostfreq;
    my $f = 0;
    foreach my $num (@nums) {
	if ($freq[$num] > $f) {
	    $f = $freq[$num];
	}
    }
    foreach my $num (@nums) {
	if ($freq[$num] == $f) {
	    push @mostfreq, $num;
	}
    }
    say "The most frequent is {@mostfreq} with $f occurrences.";
}

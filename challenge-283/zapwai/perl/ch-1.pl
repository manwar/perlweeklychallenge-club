use v5.38;
my @ints = (3, 3, 1);
proc(@ints);
@ints = (3, 2, 4, 2, 4);
proc(@ints);
@ints = (1);
proc(@ints);
@ints = (4, 3, 1, 1, 1, 4);
proc(@ints);
sub proc(@ints) {
    say "Input: \@ints = @ints";
    my $num = 0;
    for my $i (0 .. $#ints) {
	my $found = 0;
	my $elem = $ints[$i];
	for my $j (0 .. $#ints) {
	    next if ($i == $j);
	    my $new_elem = $ints[$j];
	    if ($elem == $new_elem) {
		$found = 1;
	    }
	}
	if ($found == 0) {
	    $num = $elem;
	    last;
	}
    }
    say "Output: $num";
}

use v5.38;
# Swaps one entry and returns list
sub swap(@ints) {
    my $ind = 0;
    for (0 .. $#ints) {
	if (($ints[0] != 1 && $ints[$_] == 1) || ($ints[0] == 1 && $ints[$#ints] != @ints && $ints[$_] == @ints)) {
	    $ind = $_;
	    last;
	}
    }
    my $index = ($ints[0] != 1) ? $ind - 1 : $ind + 1;
    my $val = $ints[$index];
    $ints[$index] = ($ints[0] != 1) ? 1 : scalar @ints;
    $ints[$ind] = $val;
    return @ints;
}

sub proc(@ints) {
    say "Input: \@ints = @ints";
    my $cnt = 0;
    while ($ints[0] != 1 || $ints[$#ints] != scalar @ints) {
	$cnt++;
	@ints = swap(@ints);
    }
    say "Output: $cnt";
}


my @ints = (2,1,4,3);
proc(@ints);
@ints = (2,4,1,3);
proc(@ints);
@ints = (1,3,2,4,5);
proc(@ints);

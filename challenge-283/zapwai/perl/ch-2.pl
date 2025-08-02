use v5.38;
my @ints = (1, 2, 1, 0);
proc(@ints);
@ints = (0, 3, 0);
proc(@ints);
sub proc(@ints) {
    say "Input: \@ints = @ints";
    my $veracity = "true";
    for my $i (0 .. $#ints) {
	my $freq = $ints[$i];
	my $cnt = 0;
	for my $elem (@ints) {
	    $cnt++ if ($elem == $i);
	}
	if ($cnt != $freq) {
	    $veracity = "false";
	    last;
	}
    }
    say "Output: $veracity";
}

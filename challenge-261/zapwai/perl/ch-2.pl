use v5.38;
my @ints = (5,3,6,1,12);
my $start = 3;
doubles_scan(@ints);

sub doubles_scan(@ints) {
    say "Input: \@ints = @ints, \$start = $start";
    my $flag = 1;
    do {
	$start *= 2;
	if (grep { $_ == $start } @ints) {
	    $flag = 1;
	} else {
	    $flag = 0;
	}
    } while ($flag);
    say "Output: $start";
}


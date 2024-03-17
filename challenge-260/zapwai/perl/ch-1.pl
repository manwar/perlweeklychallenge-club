use v5.36;
my @ints = (1,2,2,1,1,3);
proc(@ints);
my @ints2 = (1,2,3);
proc(@ints2);
my @ints3 = (-2,0,1,-2,1,1,0,1,-2,9);
proc(@ints3);

sub proc(@ints) {
    say "Input: \@ints = (", join(", ", @ints).")";
    say "Output: ", has_uniq_freq(@ints);
}

sub has_uniq_freq(@ints) {
    my %f = map { $_, 0 } @ints;
    $f{$_}++ foreach (@ints);
    my %g = map { $_, 0 } (values %f);
    $g{$_}++ foreach (values %f);
    for ( values %g ) {
	if ($_ > 1) {
	    return 0;
	}
    }
    return 1;
}

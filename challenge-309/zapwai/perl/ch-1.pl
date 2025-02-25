use v5.38;

sub proc(@ints) {
    say "Input: \@ints = @ints";
    my $val = $ints[1] - $ints[0];
    my $ind = 0;
    for my $i (0 .. $#ints - 1) {
	my $gap = $ints[$i+1] - $ints[$i];
	if ($gap < $val) {
	    $ind = $i;
	    $val = $gap;
	}
    }
    say "Output: $val -> $ints[$ind+1]";
}

my @ints = (2, 8, 10, 11, 15);
proc(@ints);
@ints = (1, 5, 6, 7, 14);
proc(@ints);
@ints = (8, 20, 25, 28);
proc(@ints);

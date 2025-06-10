use v5.38;
sub proc(@prices) {
    say "Input:  @prices";
    for my $i (0 .. $#prices) {
	my $price = $prices[$i];
	for my $j ($i + 1 .. $#prices) {
	    if ($prices[$j] <= $price) {
		$prices[$i] -= $prices[$j];
		last;
	    }
	}
    }
    say "Output: @prices";
}

my @prices = (8, 4, 6, 2, 3);
proc(@prices);
@prices = (1,2,3,4,5);
proc(@prices);
@prices = (7,1,1,5);
proc(@prices);

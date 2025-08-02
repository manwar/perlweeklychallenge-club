use v5.38;
my @ints = (-1, -2, -3, -4, 3, 2, 1);
proc(@ints);
@ints = (1, 2, 0, -2, -1);
proc(@ints);
@ints = (-1, -1, 1, -1, 2);
proc(@ints);

sub proc(@ints) {
    say "Input: \@ints = @ints";
    say "Output: ", sign_of_prod(@ints);
}

sub sign_of_prod(@ints) {
    my $num_of_negs = 0;
    for my $int (@ints) {
	if ($int < 0) {
	    $num_of_negs++;
	} elsif ($int == 0) {
	    return 0;
	}
    }
    return ($num_of_negs % 2 == 0) ? 1 : -1;
}

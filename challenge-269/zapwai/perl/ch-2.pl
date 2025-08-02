use v5.38;
my @ints = (2, 1, 3, 4, 5);
my @ints2 = (3,2,4);
my @ints3 = (5, 4, 3, 8);
proc(@ints);
proc(@ints2);
proc(@ints3);

sub proc(@ints) {
    say "Input: \@ints = (", join(", ", @ints), ")";
    my @arr1 = (shift @ints);
    my @arr2 = (shift @ints);
    do {
	my $x = shift @ints;
	if ($arr1[$#arr1] > $arr2[$#arr2]) {
	    push @arr1, $x;
	} else {
	    push @arr2, $x;
	}
    } while (@ints > 0);
    say "Output: \@arr1 = (", join(", ", @arr1), ") \@arr2 = (", join(", ", @arr2), ")";
}

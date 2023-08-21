use v5.30;
my @ints = (1, 34, 5, 6);
@ints = (1, 24, 51, 60);
my @new;
my @ans;
foreach my $i (0 .. $#ints) {
    if (length $ints[$i] > 1) {
	@new = split("", $ints[$i]);
	push @ans, @new;
    } else {
	push @ans, $ints[$i];
    }
}
say "Input: \@ints = (" . join(", ",@ints) . ")";
say "Output: (" . join(", ",@ans) . ")";

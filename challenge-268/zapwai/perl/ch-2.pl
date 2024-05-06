use v5.38;
my @ints = (2, 5, 3, 4);
proc(@ints);

sub proc(@ints) {
    my @new;
    say "Input: @ints";
    @ints = sort { $a <=> $b } @ints;
    do {
	my $x = shift @ints;
	my $y = shift @ints;
	push @new, $y;
	push @new, $x;
    } while ($#ints > 0);
    say "Output: @new";
}

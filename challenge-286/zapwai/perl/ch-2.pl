use v5.38;
use List::Util qw( min max );
my @ints = (2, 1, 4, 5, 6, 3, 0, 2);
proc(@ints);
@ints = (0, 5, 3, 2);
proc(@ints);
@ints = (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8);
proc(@ints);

sub proc(@ints) {
    say "Input: \@ints = (".join(", ", @ints).")";
    while (scalar @ints > 2) {
	my @L;
	for my $i (0 .. ($#ints - 1)/2) {
	    if ($i % 2 == 0) {
		push @L, min($ints[2*$i], $ints[2*$i + 1]);
	    } else {
		push @L, max($ints[2*$i], $ints[2*$i + 1]);
	    }
	}
	@ints = @L;
    }
    say "Output: " . min(@ints);
}

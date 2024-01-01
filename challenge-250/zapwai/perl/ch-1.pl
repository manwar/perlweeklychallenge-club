use v5.30;
my @ints = (0, 1, 2);
#my @ints = (4,3,2,1);
#my @ints = (1, 2, 3, 4, 5, 6, 7, 8, 9, 0);
my $index = -1;
for my $i (0 .. $#ints) {
    if ($i == $ints[$i]) {
	$index = $i ;
	last;
    }
}
say "Input: \@ints = @ints";
say "Output: $index";
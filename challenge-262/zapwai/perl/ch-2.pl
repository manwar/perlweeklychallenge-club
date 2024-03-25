use v5.38;
my @ints = (3, 1, 2, 2, 2, 1, 3);
my $k = 2;
say "Input: \@ints = (".join(",", @ints)."), \$k = $k";
my $cnt = 0;
for my $i (0 .. $#ints - 1) {
    for my $j ($i + 1 .. $#ints) {
	next unless ($ints[$i] == $ints[$j]);
	$cnt++ if ($i * $j % $k == 0);
    }
}
say "Output: $cnt";

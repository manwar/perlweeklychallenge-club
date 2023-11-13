use v5.30;
my @nums = (2,5,9);
#@nums = (7,7,7,7,7,7,7);
my $cnt = 0;
for my $n (@nums) {
    for my $m (@nums) {
	#	say "($n, $m)" . (int $n/$m);
	$cnt += (int $n/$m);
    }
}
say "Input: \@nums = (".join(", ",@nums).")";
say "Output: $cnt";

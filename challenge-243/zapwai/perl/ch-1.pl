use v5.30;
my @nums = (1,3,2,3,1);
#@nums = (2,4,3,5,1);
my $output;
my $cnt = 0;
for my $i (0 .. $#nums - 1) {
    for my $j ($i .. $#nums) {
	if ( $nums[$i] > 2 * $nums[$j] ) {
	    $output .= "($i, $j) --> ($nums[$i], $nums[$j])\n";
	    $cnt++;
	}
    }
}
say "Input: \@nums = (" .join(", ",@nums).")";
say "Output: $cnt";
chomp $output;
say $output;

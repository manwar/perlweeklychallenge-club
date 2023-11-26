use v5.30;
my @nums = (0, 1, 4, 6, 7, 10);
my $diff = 3;
print "Input: \@nums = (". join(", ", @nums) . ")";
say "\t\$diff = $diff";
my ($cnt,$output);
foreach my $i (0 .. $#nums - 2) {
    foreach my $j ($i + 1 .. $#nums - 1) {
	foreach my $k ($j + 1 .. $#nums) {
	    if ( is_trip($diff, $nums[$i],$nums[$j],$nums[$k]) ) {
		$output .= "($nums[$i],$nums[$j],$nums[$k])\n";
		$cnt++;
	    }
	}
    }
}
say "Output: $cnt";
chomp $output;
say $output;
sub is_trip {
    my ($diff, $a, $b, $c) = @_;
    return 1 if ( ($b - $a == $diff) && ($c - $b == $diff) );
    0
}

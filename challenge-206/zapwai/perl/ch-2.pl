use v5.30.0;
my @arr = (1,2,3,4);
sub min {
    my ($a, $b) = @_;
    ($a < $b) ? {return $a} : {return $b}
}
sub sum {
    my ($a,$b,$c,$d) = @_;
    min($a,$b) + min($c,$d)
}
my ($max,$out);
for my $i (0 .. $#arr - 3) {
    for my $j ($i+1 .. $#arr - 2) {
	for my $k ($j+1 .. $#arr - 1) {
	    for my $l ($k+1 .. $#arr) {
		my ($I, $J, $K, $L) = ($arr[$i],$arr[$j],$arr[$k],$arr[$l]);
		my $sum1 = sum($I,$J,$K,$L);
		my $sum2 = sum($I,$K,$J,$L);
		my $sum3 = sum($I,$L,$K,$J);
		for ($sum1, $sum2, $sum3) {
		    $max = $_ if ($max < $_);
		}
		$out .= "  ($arr[$i],$arr[$j]) & ($arr[$k],$arr[$l]) --> " . $sum1 ."\n";
		$out .= "  ($arr[$i],$arr[$k]) & ($arr[$j],$arr[$l]) --> " . $sum2."\n";
		$out .= "  ($arr[$i],$arr[$l]) & ($arr[$j],$arr[$k]) --> " . $sum3 ."\n";
	    }
	}
    }
}
say "Input: \@array = (".join(",",@arr).")";
say "Output: $max";
print $out;

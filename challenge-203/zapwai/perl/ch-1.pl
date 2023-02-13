use v5.30.0;
my @array = (1,2,3,6);
#my @array = (1,1,1,3,5);
#my @array = (3,3,6,4,5);
my $str;
my $cnt;
for my $a (0 .. $#array - 3) {
    for my $b ($a + 1 .. $#array - 2) {
	for my $c ($b + 1 .. $#array - 1) {
	    for my $d ($c + 1 .. $#array) {
		my $sum = $array[$a] + $array[$b] + $array[$c];
		if ($sum == $array[$d]) {
		    $cnt++ ;
		    $str .= "\$array[$a] + \$array[$b] + \$array[$c] == \$array[$d]\n";
		}
	    }
	}
    }
}
say "Input: \@array = (".join(",",@array).")";
$cnt = 0 unless ($cnt);
say "Output: $cnt";
print $str;

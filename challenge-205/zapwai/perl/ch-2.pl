use v5.30.0;
my @array = (1,2,3,4,5,6,7);
say "Input: \@array = (".join(",",@array).")";
print "Output: ";
my $max = 0;
my ($a,$b);
for my $i (0 .. $#array - 1) {
    for my $j ($i+1 .. $#array) {
	my $n = $array[$i]^$array[$j];
	if ($max < $n) {
	    $max = $n;
	    $a = $array[$i];
	    $b = $array[$j];
	}
    }
}
say $max . " ($a xor $b = $max)";

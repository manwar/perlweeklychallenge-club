use v5.30.0;
my @list = (-2, -1, 23, 4, -5,3);
@list = (-8, 2, -9, 0, -4, 3);
say "Input: \@list = (" . join(",",@list) . ")";
print "Output: ";
my $number_of_negatives;
foreach (@list) {
    $number_of_negatives++ if ($_ < 0);
}
if ($number_of_negatives > 1) {
    my $max;
    my ($I, $J, $K);		# solution
    for my $i (0 .. $#list - 2) {
	for my $j ($i + 1 .. $#list - 1) {
	    for my $k ($j + 1 .. $#list) {		    
		my $prod = $list[$i]*$list[$j]*$list[$k];
		if ($prod > $max) {
		    $max = $prod;
		    $I = $list[$i];
		    $J = $list[$j];
		    $K = $list[$k];
		}
	    }
	}
    }
    say "$max\n$I x $J x $K = $max";    
} else {
    @list = reverse sort {$a <=> $b} @list;
    my $prod = $list[0]*$list[1]*$list[2];
    say "$prod\n$list[0] x $list[1] x $list[2] = $prod";    
}

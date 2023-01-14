my @list = (3,0,1,1,9,7);
my ($x, $y, $z) = (7, 2, 3);
my $cnt = 0;
my $str;
loop (my $i = 0; $i < @list.elems - 2; $i++) {
    loop (my $j = $i + 1; $j < @list.elems - 1; $j++) {
	loop (my $k = $j + 1; $k < @list.elems; $k++) {
	    if (abs(@list[$i] - @list[$j]) <= $x && abs(@list[$j] - @list[$k]) <= $y && abs(@list[$k] - @list[$i]) <= $z) {	    
		$str ~= "("~join(",",@list[$i],@list[$j],@list[$k])~") \t [i:$i,j:$j,k:$k]\n";
		$cnt++;
	    }    
	}}}
say "Input: (" ~ join(",", @list) ~ ")";
say "Output: $cnt";
say chomp $str;

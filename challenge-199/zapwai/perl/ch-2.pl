use v5.30.0;
my @list = (3,0,1,1,9,7);
my $x = 7;
my $y = 2;
my $z = 3;
say "Input: (".join(",",@list).")";
print "Output: ";
my $cnt = 0;
my $str;
for my $i ( 0 .. $#list - 2) {
    for my $j ( $i + 1 .. $#list - 1) {
	for my $k ( $j + 1 .. $#list) {
	    if ( (abs($list[$i] - $list[$j]) <= $x) && (abs($list[$j] - $list[$k]) <= $y) && (abs($list[$i] - $list[$k]) <= $z) ) {
		$str .= "($list[$i],$list[$j],$list[$k]) \t [(i,j,k) = ($i,$j,$k)]\n";
		$cnt++;
	    }
	}
    }
}

chomp $str;
say "$cnt friendly triplets...\n$str";

use v5.30.0;
my @list = (2,3,-1);
say "Input:  \@list = (".join(", ",@list).")";    
for (1 .. @list) {
    my $positive_value_preceding = 0;
    last if ($#list == 0);    
    foreach my $i (0 .. $#list) {
	if ($list[$i] < 0) {
	    if ($positive_value_preceding) {
		my $bad_entry = $i;
		$bad_entry-- if ( abs($list[$i - 1]) <= abs($list[$i]) );
		if (abs($list[$i - 1]) == abs($list[$i])) {
		    splice @list, $i, 1;
		    $i--;
		}
		splice @list, $bad_entry, 1;
		$positive_value_preceding = 0;
		redo;
	    }
	} else {
	    $positive_value_preceding = 1;
	}
    }
}
say "Output: (".join(", ",@list).")";

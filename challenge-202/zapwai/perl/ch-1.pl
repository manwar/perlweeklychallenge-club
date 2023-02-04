use v5.30.0;
my @array1 = (1,5,3,6);
my @array2 = (2,6,3,5);
my @array3 = (1,2,3,4);
my @array4 = (2,3,5,7);
my @test = (\@array1, \@array2,\@array3,\@array4);    
sub are_three_odds {
    my @list = @_;
    my @ind;
    for (0 .. $#list - 2) {
	push @ind, $_ if ( ($list[$_] % 2 == 1) && ($list[$_ + 1] % 2 == 1) && ($list[$_ + 2] % 2 == 1) );
    }
    return 0 unless (@ind);
    foreach (@ind) {
	my @set = ($list[$_],$list[$_+1],$list[$_+2]);
	@set = sort {$a <=> $b} @set;
	if ( ($set[2] - $set[1]) == ($set[1] - $set[0])) {
	    return 1;
	}
    }
    return 0;
}

for (0 .. $#test) {
    my @array = @{$test[$_]};
    say "Input: (".join(",",@array).")";
    say "Output: " . are_three_odds(@array);
}

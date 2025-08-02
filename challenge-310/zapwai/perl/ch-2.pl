use v5.38;
sub proc(@ints) {
    say "Input: @ints";
    my (@evens, @odds);
    for my $i (0 .. $#ints) {
	if ($i % 2 == 0) {
	    push @evens, $ints[$i] ;
	} else {
	    push @odds, $ints[$i] ;
	}
    }
    @odds = reverse sort {$a <=> $b} @odds;
    @evens = sort {$a <=> $b} @evens;
    my @out;
    for my $i (0 .. $#ints / 2) {
	push @out, $evens[$i];
	push @out, $odds[$i] if ($odds[$i]) ;
    }
    say "Output: @out";
}


my @ints = (4,1,2,3);
proc(@ints);
@ints = (3,1);
proc(@ints);
@ints = (5,3,2,1,4);
proc(@ints);

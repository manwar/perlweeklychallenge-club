use v5.38;

sub proc(@ints) {
    say "Input: \@ints = @ints";
    my @set;
    push @set, $ints[0];
    unless ($#ints == 0) {
	my $flag = 1;
	do {
	    my $item = $ints[$set[$#set]];
	    for my $it (@set) {
		$flag = 0 if ($it == $item);
	    }
	    push @set, $item if ($flag);
	} while ($flag);
    }
    say "Output: " . scalar @set;
}

my @ints = (5,4,0,3,1,6,2);
proc(@ints);

proc(0, 1, 2);

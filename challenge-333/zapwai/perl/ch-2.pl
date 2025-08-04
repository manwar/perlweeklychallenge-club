use v5.38;

sub proc(@ints) {
    print "Input : ";
    say "(". join(", ", @ints).")";
    my @z;			# zero locations
    my @o;			# output
    my $cnt = 0;		# length lost to zeros
    for my $i (0 .. $#ints) {
	my $integer = $ints[$i];
	if ($integer == 0) {
	    $cnt++;
	    push @o, (0,0);
	} else {
	    push @o, $integer;
	}
	last if ($cnt + $i >= $#ints);
    }
    pop @o if (scalar(@o) > scalar(@ints));
    say "Output: (".join(", ", @o).")";
}

my @ints = (1, 0, 2, 3, 0, 4, 5, 0);
proc(@ints);
@ints = (1,2,3);
proc(@ints);
@ints = (1,2,3,0);
proc(@ints);
@ints = (0,0,1,2);
proc(@ints);
@ints = (1, 2, 0, 3, 4);
proc(@ints);

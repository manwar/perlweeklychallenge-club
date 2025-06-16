use v5.38;

sub proc(@ints) {
    say "Input: \@ints = @ints";
    my (@e, @o);
    for my $i (0 .. $#ints) {
	if ($i % 2 == 0) {
	    push @e, $ints[$i];
	} else {
	    push @o, $ints[$i];
	}
    }
    my @l;
    for my $i (0 .. $#e) {
	my $len = $e[$i];
	my $val = $o[$i];
	push @l, $val for (1 .. $len);
    }
    say "Output: @l";
}

my @ints = (1,3,2,4);
proc(@ints);
@ints = (1,1,2,2);
proc(@ints);
@ints = (3,1,3,2);
proc(@ints);

use v5.38;

sub proc(@ints) {
    say "Input: \@ints = @ints";
    my @peaks;
    push @peaks, 0 if ($ints[0] > $ints[1]);
    for my $i (1 .. $#ints-1) {
	push @peaks, $i if ($ints[$i] > $ints[$i-1]
			    && $ints[$i] > $ints[$i+1]);
    }
    push @peaks, $#ints if ($ints[$#ints] > $ints[$#ints-1]);
    say "Output: @peaks";
}

my @ints = (1,3,2);
proc(@ints);
@ints = (2, 4, 6, 5, 3);
proc(@ints);
@ints = (1, 2, 3, 2, 4, 1);
proc(@ints);
@ints = (5, 3, 1);
proc(@ints);
@ints = (1, 5, 1, 5, 1, 5, 1);
proc(@ints);

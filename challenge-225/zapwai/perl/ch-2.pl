use v5.30;
my @ints = (10, 4, 8, 3);
#my @ints = (1,2,3,4,5);
my @left = left(@ints);
my @right = right(@ints);
my @diff;
push @diff, abs $left[$_] - $right[$_] for (0 .. $#left);
say "Input: \@ints = @ints";
say "Output: @diff";
say "\t\@left = @left";
say "\t\@right = @right";
say "\t\@diff = @diff";
sub left {
    my @ints = @_;
    pop @ints;
    my @R = (0);
    foreach (@ints) {
	push @R, $R[-1] + $_;
    }
    return @R;
}
sub right {
    my @ints = @_;
    shift @ints;
    my @R = (0);    
    foreach (reverse @ints) {
	unshift @R, $R[0] + $_;
    }
    return @R;
}

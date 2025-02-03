use v5.38;
sub proc(@ints) {
    say "Input: \@ints = @ints";
    my @int = sort {$a <=> $b} @ints;
    my @ind;

    for my $i (0 .. $#ints) {
	push @ind, $i if ($ints[$i] != $int[$i]);
    }
    say "Output: @ind";
}
my @ints = (5,2,4,3,1);
proc(@ints);
@ints = (1,2,1,1,3);
proc(@ints);
@ints = (3,1,3,2,3);
proc(@ints);

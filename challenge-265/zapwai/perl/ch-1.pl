use v5.38;
my @ints = (1,2,3,3,3,3,4,2);
my @ints2 = (1,1);
my @ints3 = (1,2,3);
proc(@ints);
proc(@ints2);
proc(@ints3);

sub proc(@ints) {
    say "Input: \@ints = (", join(", ", @ints) . ")";
    my $third = @ints / 3;
    my @freq = (0,0,0,0,0);
    $freq[$_]++ for (@ints);
    my @ans;
    for my $val (0 .. $#freq) {
	push @ans, $val if ($freq[$val] >= $third);
    }
    @ans = sort {$a <=> $b} @ans;
    say "Output: $ans[0]";
}

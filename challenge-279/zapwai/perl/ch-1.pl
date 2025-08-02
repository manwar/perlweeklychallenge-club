use v5.38;
my @letters = ('R', 'E', 'P', 'L');
my @weights = (3, 2, 1, 4);
proc(\@letters, \@weights);
@letters = ('A', 'U', 'R', 'K');
@weights = (2, 4, 1, 3);
proc(\@letters, \@weights);
@letters = ('O', 'H', 'Y', 'N', 'P', 'T');
@weights = (5, 4, 2, 6, 1, 3);
proc(\@letters, \@weights);

sub proc($l, $w) {
    say "Input: \@letters = @$l, \@weights = @$w";
    my $N = scalar @$l;
    my @ans = ("") x $N;
    for my $i (0 .. $N - 1) {
	$ans[$$w[$i] - 1] = $$l[$i];
    }
    say "Output: ", @ans;
}

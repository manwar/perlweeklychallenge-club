use v5.38;
my @ints1 = (1, 5, 3, 2, 4, 2); my $k1 = 2;
my @ints2 = (1, 2, 4, 3, 5); my $k2 = 6;
my @ints3 = (5, 3, 2, 4, 2, 1); my $k3 = 4;
proc($k1, @ints1);
proc($k2, @ints2);
proc($k3, @ints3);

sub proc($k, @ints) {
    say "Input: \@ints = " . join(", ", @ints);
    @ints = sort { $a <=> $b } @ints;
    my @ind = grep { $ints[$_] == $k } (0 .. $#ints);
    say "Output: " . join(", ", @ind);
}

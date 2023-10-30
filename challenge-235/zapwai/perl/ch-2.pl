use v5.30;
my @ints = (1, 0, 2, 3, 0, 4, 5, 0);
say "Input: \@ints = (" .join(", ",@ints).")";
my $L = $#ints;
my @ind;
for my $i (0 .. $L - 1) {
    next unless ($ints[$i] == 0);
    push @ind, $i;
}
foreach my $i (@ind) {
    my @new = (@ints[0 .. $i], 0, @ints[$i+1 .. $L - 1]);
    @ints = @new;
}
say "Output: (" .join(", ",@ints).")";

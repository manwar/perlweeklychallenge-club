use v5.30;
my @ints = (1, 1, 4, 2, 1, 3);
# my @ints = (5, 1, 2, 3, 4);
# my @ints = (1, 2, 3, 4, 5);
my @sort = sort @ints;
my $cnt = 0;
for (0 .. $#sort) {
    $cnt++ if ($sort[$_] - $ints[$_] == 0);
}

say "Input: \@ints = (" . join(",",@ints) . ")";
say "Output: $cnt" ;

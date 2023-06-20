use v5.30;
my @ints1 = (1, 1, 4, 2, 1, 3);
my @ints2 = (5, 1, 2, 3, 4);
my @ints3 = (1, 2, 3, 4, 5);
my @integ = (\@ints1, \@ints2, \@ints3);
for my $r (@integ) {
    my @ints = @$r;
    my @sort = sort {$a <=> $b}  @ints;
    my $cnt = 0;
    for (0 .. $#sort) {
	$cnt++ if ($sort[$_] - $ints[$_] == 0);
    }
    say " Input: \@ints = (" . join(",",@ints) . ")";
    say "Sorted: \@sort = (" . join(",",@sort) . ")";
    say "Output: $cnt" ;
}

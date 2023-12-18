use v5.30;
my @ints = (3,2,1,4);
say "Input: \@ints = (".join(", ", @ints).")";
my ($min, $max) = (1000000, 0);
for my $current (@ints) {
    $max = $current if ($max < $current);
    $min = $current if ($min > $current);
}
my @bad;
for my $i (0 .. $#ints) {
    if (($ints[$i] == $max) or ($ints[$i] == $min) ) {
	push @bad, $i;
    }
}
splice @ints, $_, 1 foreach (reverse @bad);
print "Output: ";

my $out = (!@ints) ? "-1" : join(", ",@ints);
say $out;

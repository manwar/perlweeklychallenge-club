use v5.38;

sub proc($n, @ints) {
    say "Input: \@ints = @ints, \$n = $n";
    my $maxavg = 0;
    my @maxlist;
    for my $i (0 .. @ints - $n) {
	my $avg = 0;
	my @list;
	for my $j (0 .. $n - 1) {
	    $avg += $ints[$j+$i];
	    push @list, $ints[$j+$i];
	}
	$avg /= $n;
	if ($maxavg < $avg) {
	    $maxavg = $avg;
	    @maxlist = @list;
	}
    }
    say "Output: $maxavg from subarray: @maxlist";
}

my @ints = (1, 12, -5, -6, 50, 3);
my $n = 4;
proc($n, @ints);
@ints = (5);
$n = 1;
proc($n, @ints);

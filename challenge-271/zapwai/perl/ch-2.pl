use v5.38;
my @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8);
proc(@ints);
@ints = (1024, 512, 256, 128, 64);
proc(@ints);
sub proc(@ints) {
    say "Input: @ints";
    my @count;
    my $j = 0;
    for my $i (@ints) {
	my $bin = sprintf("%b", $i);
	my @dig = split "", $bin;
	$count[$j] = scalar grep { $_ == 1 } @dig;
	$j++;
    }
    my @ord = @ints;
    my $c = 1;
    while ($c != 0) {
	$c = 0;
	for my $i (0 .. $#ord - 1) {
	    if ($count[$i] > $count[$i+1]) {
		$c++;
		my $tmp_cnt = $count[$i];
		my $tmp_int = $ord[$i];
		$count[$i] = $count[$i+1];
		$count[$i+1] = $tmp_cnt;
		$ord[$i] = $ord[$i+1];
		$ord[$i+1] = $tmp_int;
	    }
	}
    }
    $c = 1;
    while ($c != 0) {
	$c = 0;
	for my $i (0 .. $#ord - 1) {
	    if ($count[$i] != $count[$i+1]) {
		next;
	    }
	    if ($ord[$i] > $ord[$i+1]) {
		$c++;
		my $tmp_int = $ord[$i];
		$ord[$i] = $ord[$i+1];
		$ord[$i+1] = $tmp_int;
		my $tmp_cnt = $count[$i];
		$count[$i] = $count[$i+1];
		$count[$i+1] = $tmp_cnt;
	    }
	}
    }
    say "Output: @ord";
}

use v5.38;
sub proc(@ints) {
    say "Input: \@ints = @ints";
    my $total = 0;
    for my $o (1 .. @ints) {
	next if ($o % 2 == 0);
	my $last = @ints - $o;
	for my $shift (0 .. $last) {
	    my $sum = 0;
	    my $n = $o;
	    for my $i (1 .. $n) {
		$sum += $ints[$shift + $i - 1];
	    }
	    $total += $sum;
	}
    }
    # Read incorrectly the first time.
    # Here is all subsets of odd length.
    # for my $num (0 .. 2**@ints - 1) {
    # 	my $form = "%0" . @ints . "b";
    # 	my $x = sprintf($form, $num);
    # 	my $count = 0;
    # 	my @dig = split "", $x;
    # 	for my $i (@dig) {
    # 	    $count++ if ($i == 1);
    # 	}
    # 	next unless ($count % 2 == 1);
    # 	my $sum = 0;
    # 	for (0 .. $#dig) {
    # 	  $sum += $ints[$_] if ($dig[$_] == 1);
    # 	$total += $sum;
    # }
    say "Output: $total";
}

my @ints = (2,5,3,6,4);
proc(@ints);
@ints = (1,3);
proc(@ints);

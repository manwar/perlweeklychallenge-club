use v5.38;
my @ints = (1, 2, 3, 4, 5);
my @ints2 = (2, 3, 8, 16);
my @ints3 = (1, 3, 5, 7, 9);
proc(@ints);
proc(@ints2);
proc(@ints3);

sub truth(@ints) {
    my $N = @ints;
    for my $i (0 .. 2**$N - 1) {
	my $d = sprintf '%b', "$i";
	$d = '0' x ($N - length $d) . $d;
	my @D = split "", $d;
	my @current_list;
	for my $j (0 .. $#D) {
	    if (1 eq $D[$j]) {
		push @current_list, $ints[$j];
	    }
	}
	next if (1 >= @current_list);
	my $tally = 0;
	$tally = $tally | $_ for (@current_list);
	my $x = sprintf "%b", $tally;
	my $last_bin_dig = substr $x, -1;
	if ($last_bin_dig eq '0') {		
	    print join(", ", @current_list), " -> $x\t";
	    return 1;
	}
    }
    return 0;
}

sub proc(@ints) {
    say "Input: \@ints = (", join(", ", @ints), ")";
    print "Output: ";
    if (truth(@ints)) {
	say "true";
    } else {
	say "false";
    }
}


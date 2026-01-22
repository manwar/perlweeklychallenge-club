use v5.38;

sub proc($int) {
    say "Input: $int";
    my @list;			# strings
    my @vals;			# values (for sorting)
    my @group = (1 .. $int);

    for my $i (@group) {
	for my $j (@group) {
	    push @list, "$j/$i";
	    push @vals, $j/$i;
	}
    }

    # Remove duplicates
    my @remove;			# indices to be removed
    for my $i (0 .. $#vals - 1) {
	for my $j ($i + 1 .. $#vals) {
	    if ($vals[$i] == $vals[$j]) {
		push @remove, $j;
	    }
	}
    }

    my @L;
    my @V;

    for my $i (0 .. $#list) {
	my $badness = 0;
	for my $bad_index (@remove) {
	    if ($i == $bad_index) {
		$badness = 1;
		last;
	    }
	}
	if ($badness) {
	    next;
	} else {
	    push @L, $list[$i];
	    push @V, $vals[$i];
	}
    }

    # Sort
    my $clear = 1;
    while ($clear) {
	$clear = 0;
	for my $i (0 .. $#V - 1) {
	    if ($V[$i] > $V[$i+1]) {
		$clear++;
		my $VAL = $V[$i];
		my $STR = $L[$i];
		$V[$i] = $V[$i+1];
		$L[$i] = $L[$i+1];
		$V[$i+1] = $VAL;
		$L[$i+1] = $STR;
	    }
	}
    }
    
    say "Output: @L";
}

my $int = 3;
proc($int);
$int = 4;
proc($int);
$int = 1;
proc($int);
$int = 6;
proc($int);
$int = 5;
proc($int);

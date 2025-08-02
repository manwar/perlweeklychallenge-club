use v5.38;

sub stock_list($fref, $iref, $inref) {
    my @ints = @$iref;
    my @list = @$inref;

    my @L;
    for my $i (@list) {
	my @newlist;
	my $val = $ints[$i];
	if ($i + $val >= $#ints) {
	    $$fref = 1;
	    last;
	} else {
	    for my $jump (1 .. $val) {
		push @newlist, $i + $jump;
	    }
	    push @L, @newlist;
	}
    }
    return \@L;
}

sub proc(@ints) {
    say "Input: \@ints = {@ints}";
    my $flag = 0;
    my $cnt = 1;
    my $val = $ints[0];
    unless ($val >= $#ints) {
	$cnt++;
	my @list;
	for my $jump (1 .. $val) {
	    push @list, $jump;
	}

	my $ref = stock_list(\$flag, \@ints, \@list);
	my @L = @$ref;

	unless ($flag == 1) {
	    if (@L) {
		while ($flag != 1) {
		    $cnt++;
		    my $Llen = $#L;
		    my $newref = stock_list(\$flag, \@ints, \@L);
		    push @L, @$newref;
		    for (0 .. $Llen) {
			shift @L;
		    }
		}
	    } else {
		$cnt = -1;
	    }
	}
    }
    say "Output: ", $cnt;
}

my @ints = (2, 3, 1, 1, 4);
proc(@ints);
@ints = (2,3,0,4);
proc(@ints);
@ints = (2,0,0,4);
proc(@ints);
@ints = (2,1,1,3,1,1,4);
proc(@ints);


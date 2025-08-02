use v5.38;
my $matrix = [ [1, 0, 0],
	       [0, 0, 1],
	       [1, 0, 0],
	   ];

my $matrix2 = [ [1, 0, 0],
		[0, 1, 0],
		[0, 0, 1],
	    ];

sub is_special($m, $M, $N, $i, $j) {
    return 0 if ($$m[$i][$j] != 1);
    for my $k (0 .. $M) {
	next if ($k == $i);
	return 0 if ($$m[$k][$j] != 0);
    }
    for my $k (0 .. $N) {
	next if ($k == $j);
	return 0 if ($$m[$i][$k] != 0);
    }
    return 1;
}

sub proc($m) {
    my $M = @$m - 1;
    my $N = @{$$m[0]} - 1;
    say "Input: m = ";
    my $cnt = 0;
    for my $i (0 .. $M) {
	print "\t";
	for my $j (0 .. $N) {
	    print $$m[$i][$j];
	    $cnt++ if is_special($m, $M, $N, $i, $j);
	}
	print "\n";
    }
    say "Output: $cnt";
}

proc($matrix);
proc($matrix2);

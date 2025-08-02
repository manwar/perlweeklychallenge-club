use v5.38;
my $matrix = [ [0, 1],
	       [1, 0],
	   ];
proc($matrix);
$matrix = [ [0, 0, 0],
	    [1, 0, 1],
	];
proc($matrix);
$matrix = [ [0, 0],
	    [1, 1],
	    [0, 0],
	];
proc($matrix);
sub proc($m) {
    say "Input: \$m = ";
    my @cnt = (0) x scalar @$m;
    my $pres = 0;
    for my $row (@$m) {
	say "\t @$row";
	for my $entry (@$row) {
	    if ($entry == 1) {
		$cnt[$pres]++;
	    }
	}
	$pres++;
    }
    my $max = 0;
    my $max_index = 0;
    for my $i (0 .. $#cnt) {
	if ($cnt[$i] > $max) {
	    $max_index = $i;
	    $max = $cnt[$i];
	}
    }
    say "Output: row ", $max_index + 1, " (count is $max)";
}


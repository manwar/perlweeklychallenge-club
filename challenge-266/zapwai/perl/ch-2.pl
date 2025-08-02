use v5.38;
my $matrix = [ [1, 0, 0, 2],
	       [0, 3, 4, 0],
	       [0, 5, 6, 0],
	       [7, 0, 0, 1],
	   ];
proc($matrix);

$matrix = [ [1, 2, 3],
	    [4, 5, 6],
	    [7, 8, 9],
	];
proc($matrix);

$matrix = [ [1, 0, 2],
	    [0, 3, 0],
	    [4, 0, 5],
	];
proc($matrix);

sub proc($matrix) {
    my $fail = 0;
    my $N = $#{$matrix};
    say "Input: matrix = ";
    for my $i (0 .. $N) {
	print "\t";
	for my $j (0 .. $N) {
	    print $$matrix[$i][$j];
	    if (($i == $j) || ($i == $N - $j)) {
		$fail = 1 unless ($$matrix[$i][$j] != 0);
	    } else {
		$fail = 1 unless ($$matrix[$i][$j] == 0);
	    }
	}
	say "";
    }
    say "Output: ", ($fail == 0) ? "True" : "False";
}

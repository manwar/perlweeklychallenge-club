use v5.36;

sub is_echelon ($M) {
    my ($w, $h) = (scalar @$M, scalar @{$$M[0]});
    # The number of zeroes leading each row must not decrease.
    my $zero_cnt = 0;
    for my $i (0 .. $w - 1) {
	my @row = @{$$M[$i]};
	my $current_count = 0;
	for my $j (0 .. $#row) {
	    if ($row[$j] == 0) {
		$current_count++;
	    } else {
		last;
	    }
	}
	if ($current_count < $zero_cnt) {
	    return 0;
	} else {
	    $zero_cnt = $current_count;
	}
    }
    return 1;
}

sub is_reduced ($M) {
    my ($r, $c) = (scalar @$M, scalar @{$$M[0]});
    for my $i (0 .. $r - 1) {	# Check for leading ones.
	my @row = @{$$M[$i]};
	for my $j (0 .. $#row) {
	    next if ($row[$j] == 0);
	    last if ($row[$j] == 1);
	    return 0;
	}
    }
    # Check for nonzero entries above/below the 1. Skip the last fv cols.
    my $fv = $c - $r; # Number of free vars (fv).     # Need to do case where this is negative
    for my $j (0 .. $c - $fv - 1) {
	my @col = map { ${${$M}[$_]}[$j] } (0 .. $r - 1);
	my $cnt = 0;
	for my $c (@col) {
	    $cnt++ if ($c != 0); 
	}
	return 0 if ($cnt > 1);
    }
    return 1;
}

sub check ($M) { is_echelon($M) && is_reduced($M) }

sub proc($M) {
    say "Input: M = [";
    say "\t[".join(", ", @$_)."]" for @$M; say "\t]";
    say "Output: " . check($M);
}

my $M = [
    [1,0,0,1],
    [0,1,0,2],
    [0,0,1,3]
];

proc($M);

$M = [
    [1, 1, 0],
    [0, 1, 0],
    [0, 0, 0]
];

proc($M);

$M = [
    [0, 1,-2, 0, 1],
    [0, 0, 0, 1, 3],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0]
];

proc($M);

$M = [
    [1, 0, 0, 4],
    [0, 1, 0, 7],
    [0, 0, 1,-1]
];

proc($M);

$M = [
    [0, 1,-2, 0, 1],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 1, 3],
    [0, 0, 0, 0, 0]
];

proc($M);

$M = [
    [0, 1, 0],
    [1, 0, 0],
    [0, 0, 0]
];

proc($M);

$M = [
    [4, 0, 0, 0],
    [0, 1, 0, 7],
    [0, 0, 1,-1]
];

proc($M);

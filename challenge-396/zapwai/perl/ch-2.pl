use v5.38;

sub trionic($p, $q, @n) {
    for my $i (0 .. $p - 1) {
	return 0 if ($n[$i] >= $n[$i+1])
    }
    for my $i ($p .. $q - 1) {
	return 0 if ($n[$i] <= $n[$i+1])
    }
    for my $i ($q .. $#n - 1) {
	return 0 if ($n[$i] >= $n[$i+1])
    }
    return 1;
}

sub proc(@n) {
    say "Input: @n";
    my $out = "false";
    for my $p (1 .. $#n - 2) {
	for my $q ($p + 1 .. $#n - 1) {
	    $out = "true" if (trionic($p, $q, @n) == 1);
	}
    }
    say "Output: $out";
}

my @arr = (1, 3, 5, 4, 2, 6, 8);
proc(@arr);
@arr = (1, 4, 4, 2, 1, 3, 5);
proc(@arr);
@arr = (2, 10, 3, 1, 9);
proc(@arr);
@arr = (1, 2, 3, 4, 3, 2, 1);
proc(@arr);
@arr = (1, 3, 6, 4, 2, 7, 8, 4);
proc(@arr);

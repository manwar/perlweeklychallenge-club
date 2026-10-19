use v6;

sub trionic($p, $q, @n) {
    for 0 .. $p - 1 -> $i {
	return 0 if @n[$i] >= @n[$i+1];
    }
    for $p .. $q - 1 -> $i {
	return 0 if @n[$i] <= @n[$i+1];
    }
    for $q .. @n.end - 1 -> $i {
	return 0 if @n[$i] >= @n[$i+1];
    }
    return 1;
}

sub proc(@n) {
    say "Input: " ~ @n;
    my $out = "false";
    for 1 .. @n.end - 2 -> $p {
	for $p + 1 .. @n.end - 1 -> $q {
	    $out = "true" if trionic($p, $q, @n) == 1;
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

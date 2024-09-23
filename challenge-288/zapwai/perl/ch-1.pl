use v5.38;
my $s = "123";
proc($s);
$s = "2";
proc($s);
$s = "1400";
proc($s);

sub is_pal($s) {
    my $r = reverse $s;
    return ($s eq $r);
}

sub proc($s) {
    say "Input: $s";
    my $n = $s;
    my $found = 0;
    my $step = 1;
    while ($found == 0) {
	my $m = $n - $step;
	if (is_pal($m)) {
	    $found = 1;
	    $n = $m;
	} else {
	    $m = $n + $step;
	    if (is_pal($m)) {
		$found = 1;
		$n = $m;
	    }
	}
	$step++;
    }
    say "Output: $n";
}

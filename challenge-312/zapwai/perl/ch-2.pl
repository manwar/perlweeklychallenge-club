use v5.38;
sub proc($str) {
    say "Input: \$str = $str";
    my (@r, @b, @g);
    for (0 .. 9) {
	$r[$_] = 0;
	$b[$_] = 0;
	$g[$_] = 0;
    }
    for my $i (0 .. (0.5 * length $str) - 1) {
	my ($color, $box) = split '', substr $str, 2*$i, 2;
	if ($color eq 'R') {
	    $r[$box]++;
	} elsif ($color eq 'B') {
	    $b[$box]++;
	} else {
	    $g[$box]++;
	}
    }
    my $cnt;
    for my $i (0 .. 9) {
	$cnt++ if ($r[$i] > 0 && $b[$i] > 0 && $g[$i] > 0);
    }
    say "Output: ", $cnt // -1;
}

my $str = "G0B1R2R0B0";
proc($str);
$str = "G1R3R6B3G6B1B6R1G3";
proc($str);
$str = "B3B2G1B3";
proc($str);

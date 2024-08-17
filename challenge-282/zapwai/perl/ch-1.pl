use v5.38;
my $int = 123444567;
proc($int);
$int = 1233334;
proc($int);
$int = 10020003;
proc($int);
sub proc($int) {
    say "Input: $int";
    my $num = -1;
    my $current = 0;
    my $prev = 0;
    my $cnt = 0;
    my @num = split "", $int;
    for my $i (0 .. -1 + length $int) {
	$prev = $current;
	$current = $num[$i];
	if ($prev == $current) {
	    $cnt++;
	} else {
	    if ($cnt == 2) {
		$num = $prev;
		last;
	    } else {
		$cnt = 0;
	    }
	}
    }
    say "Output: $num";
}

sub proc($n) {
    say "Input: $n";
    my @a;
    unless $n == 0 {
	for (1 .. 10000) {
	    my ($ucnt, $dcnt) = (0,0);
	    my $s = "U";
	    $ucnt++;

	    while ($s.chars < 2*$n) {
		if $ucnt > $dcnt {
		    my $r = rand;
		    if $r > 0.5 {
			$s ~= "D";
			$dcnt++;
		    } else {
			$s ~= "U";
			$ucnt++;
		    }
		} else {
		    $s ~= "U";
		    $ucnt++;
		}
	    }
	    push @a, $s unless ((grep {$_ eq $s}, @a) || ($ucnt != $dcnt));
	}
    }
    @a = sort @a;
    say "Output: ", join " ", @a;
}

my $n = 1;
proc($n);
$n = 2;
proc($n);
$n = 3;
proc($n);
$n = 0;
proc($n);
$n = 4;
proc($n);

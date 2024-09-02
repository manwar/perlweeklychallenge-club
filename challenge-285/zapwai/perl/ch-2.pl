use v5.38;
my $amt = $ARGV[0] // 100;
my $cnt = 0;
for my $h (0 .. $amt/50) {
    for my $q (0 .. $amt/25) {
	for my $d (0 .. $amt/10) {
	    for my $n (0 .. $amt/5) {
		for my $p (0 .. $amt) {
		    if (tally($p, $n, $d, $q, $h) == $amt) {
			$cnt++;
		    }
		}
	    }
	}
    }
}
say "There are $cnt ways to make change for $amt cents";
sub tally($p, $n, $d, $q, $h) { $p + 5*$n + 10*$d + 25*$q + 50*$h }


use v5.38;

sub proc(@dom) {
    print "Input: \@dominos = ";
    print join(",", (@$_)), " " for (@dom);
    print "\n";
    my $cnt = 0;
    my @dm; 			# list of matching dominos already found
  out: for my $i (0 .. $#dom - 1) {
	my $d = $dom[$i];
	my ($a, $b) = @$d;
	for my $j ($i + 1 .. $#dom) {
	    my $e = $dom[$j];
	    my ($c, $d) = @$e;
	    if (($a == $c && $b == $d) || ($a == $d && $b == $c)) {
		my $k = join "", sort($a,$b);
		push @dm, $k unless (grep {/$k/} @dm);
		$cnt++;
		next out;
	    }
	}
    }
    $cnt += @dm;
    say "Output: $cnt";
}

my @dom = ([1, 3], [3, 1], [2, 4], [6, 8]);
proc(@dom);
@dom = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2]);
proc(@dom);
@dom = ([1, 2], [2, 1], [1, 2], [1, 2], [2, 2]);
proc(@dom);
@dom = ([1, 2], [2, 1], [1, 2], [2,3], [1, 2], [3, 2], [2,3]);
proc(@dom);
@dom = ([1, 2], [1, 2], [2,3], [1, 2], [3, 2], [2,3], [4,5], [6,1], [1,1]);
proc(@dom);

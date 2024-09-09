use v5.38;
my @routes = (["B","C"], ["D","B"], ["C","A"]);
proc(@routes);
@routes = (["A","Z"]);
proc(@routes);

sub proc(@routes) {
    print "Input: ";
    print join(",", @{$routes[$_]})," " for (0 .. $#routes);
    print "\n";
    my @in;
    my @out;
    foreach (@routes) {
	push @in, ${$_}[0];
	push @out, ${$_}[1];
    }
    my $ans = "a";
    for my $needle (@out) {
	my $found = 0;
	for my $hay (@in) {
	    if ($needle eq $hay) {
		$found = 1;
		last;
	    }
	}
	if ($found == 0) {
	    $ans = $needle;
	}
    }
    say "Output: $ans";
}


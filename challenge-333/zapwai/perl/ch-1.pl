use v5.38;
sub slope($x1, $y1, $x2, $y2) {
    return ($y2 - $y1)/($x2-$x1);
}

sub proc(@l) {
    print "Input: ";
    my @x;
    my @y;
    foreach (@l) {
	print "[".join(",",@$_)."] ";
	push @x, $$_[0];
	push @y, $$_[1];
    }
    print "\n";

    my $dx = $x[1] - $x[0];
    if ($dx == 0) {
	if ($x[1] == $x[2]) {
	    say "Output: true";
	} else {
	    say "Output: false";
	}
    } else {
	my $s1 = slope($x[0],$y[0],$x[1],$y[1]);
	my $s2 = slope($x[1],$y[1],$x[2],$y[2]);
	($s1 == $s2) ? say "Output: true" : say "Output: false";
    }
}

my @list = ([2, 1], [2, 3], [2, 5]);
proc(@list);
@list = ([1, 4], [3, 4], [10, 4]);
proc(@list);
@list = ([0, 0], [1, 1], [2, 3]);
proc(@list);
@list = ([1, 1], [1, 1], [1, 1]);
proc(@list);
@list = ([1000000, 1000000], [2000000, 2000000], [3000000, 3000000]);
proc(@list);


use v5.38;
sub proc($x, $y, @p) {
    print "Input: \$x = $x, \$y = $y, \@points = ";
    print "[".join(", ", @$_)."] " for (@p);
    print "\n";
    my @ind;			# list of valid points
    my @dist;			# list of distances
    for my $i (0 .. $#p) {
	my @pt = @{$p[$i]};
	my $current_x = $pt[0];
	my $current_y = $pt[1];
	if ($current_x == $x || $current_y == $y) {
	    push @ind, $i;
	    push @dist, abs($x - $current_x) + abs($y - $current_y);
	}
    }
    if (@ind) {
	my $min = $dist[0];
	my $minind = 0;
	for my $i (0 .. $#ind) {
	    if ($min > $dist[$i]) {
		$min = $dist[$i];
		$minind = $i;
	    }
	}
	my $o = $ind[$minind];
	say "Output: $o";
    } else {
	say "Output: -1";
    }
}
my ($x, $y, @points);
$x = 3, $y = 4, @points = ([1, 2], [3, 1], [2, 4], [2, 3]);
proc($x, $y, @points);
$x = 2, $y = 5, @points = ([3, 4], [2, 3], [1, 5], [2, 5]);
proc($x, $y, @points);
$x = 1, $y = 1, @points = ([2, 2], [3, 3], [4, 4]);
proc($x, $y, @points);
$x = 0, $y = 0, @points = ([0, 1], [1, 0], [0, 2], [2, 0]);
proc($x, $y, @points);
$x = 5, $y = 5, @points = ([5, 6], [6, 5], [5, 4], [4, 5]);
proc($x, $y, @points);

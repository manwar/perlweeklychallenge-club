use v5.38;
sub proc(@points) {
    print "Input: ";
    print join(",", @$_), " " for (@points);
    print "\n";
    my @m;
    for my $i (0 .. $#points - 1) {
	my @p1 = @{$points[$i]};
	my @p2 = @{$points[$i+1]};
	my ($x1, $y1) = ($p1[0], $p1[1]);
	my ($x2, $y2) = ($p2[0], $p2[1]);
	my $m = ($y2 - $y1) / ($x2 - $x1);
	push @m, $m;
    }
    say "Output: ", ($m[0] == $m[1]) ? "false" : "true";
	
}
my @points = ( [1, 1], [2, 3], [3,2] );
proc(@points);
@points = ( [1, 1], [2, 2], [3, 3] );
proc(@points);

use v5.38;
my @x = (3, 7, 5);
my @y = (9, 5, 7);
proc(\@x, \@y);

sub check($x, $y) {
    my $cnt = 0;
    for (0 .. scalar @$x - 1) {
	$cnt++ if ($$x[$_] == $$y[$_]);
    }
    return ( $cnt == scalar @$x )
}

sub proc($x, $y) {
    my @x = @$x;
    my @y = @$y;
    say "Input:  \@x = @x\n\t\@y = @y";
    print "Output: ";
    @x = sort { $a <=> $b } @x;
    @y = sort { $a <=> $b } @y;
    for my $i (-99 .. 99) {
	my @n = @x;
	foreach (0 .. $#n) {
	    $n[$_] += $i;
	}
	if (check(\@n, \@y)) {
	    say "$i";
	}
    }
    
}

use v5.38;
my $start = "g2";
my $end = "a8";
proc($start, $end);

$start = "g2";
$end = "h2";
proc($start, $end);

sub proc($start, $end) {
    say "Input: $start to $end";
    my @list = [moves($start)];
    my $round = -1;
    my $found = 0;
    while ($found == 0) {
	$round++;
	for my $old_move (@{$list[$round]}) {
	    if ($old_move eq $end) {
		$found = 1;
	    }
	}
	if ($found == 1) {
	    last;
	} else {
	    my @L;
	    for my $old_move (@{$list[$round]}) {
		push @L, moves($old_move);
	    }
	    push @list, \@L;
	}
    }
    $round++;
    say "Output: $round";
}

sub moves($coord) {
    my ($l, $row) = split "", $coord;
    my $cols = "abcdefgh";
    my $col = 1 + index $cols, $l;
    my @r;
    my @c;
    for my $i (-2, 2) {
	for my $j (-1, 1) {
	    push @c, $col + $i;
	    push @r, $row + $j;
	}
    }
    for my $i (-1, 1) {
	for my $j (-2, 2) {
	    push @c, $col + $i;
	    push @r, $row + $j;
	}
    }
    my @list;
    for my $i (0 .. 7) {
	next if ($c[$i] < 1 or $c[$i] > 8);
	next if ($r[$i] < 1 or $r[$i] > 8);
	my $move = substr($cols, $c[$i] - 1, 1).$r[$i];
	push @list, $move;
    }
    return @list;
}

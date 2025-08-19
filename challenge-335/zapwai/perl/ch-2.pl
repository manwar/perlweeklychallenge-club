use v5.38;

sub winner(@m) {
    return "Pending" if (@m < 5);
    my (@a, @b);
    for my $i (0 .. $#m) {
	if ($i % 2 == 0) {
	    push @a, $m[$i];
	} else {
	    push @b, $m[$i];
	}
    }
    my (@ax, @ay);
    for (@a) {
	push @ax, $$_[0];
	push @ay, $$_[1];
    }
    my (@bx, @by);
    for (@b) {
	push @bx, $$_[0];
	push @by, $$_[1];
    }
    my $win = "Draw";
    if (
	($ax[0] == $ax[1] && $ax[1] == $ax[2]) ||
	($ay[0] == $ay[1] && $ay[1] == $ay[2]) ||
	($ax[0] == $ay[0] && $ax[1] == $ay[1] && $ax[2] == $ay[2]) ||
	($ax[0]+$ay[0] == 2 && $ax[1]+$ay[1] == 2 && $ax[2]+$ay[2] == 2)
    ) {
	$win = "A";
    } elsif (
	($bx[0] == $bx[1] && $bx[1] == $bx[2]) ||
	($by[0] == $by[1] && $by[1] == $by[2]) ||
	($bx[0] == $by[0] && $bx[1] == $by[1] && $bx[2] == $by[2]) ||
	($bx[0]+$by[0] == 2 && $bx[1]+$by[1] == 2 && $bx[2]+$by[2] == 2)
    ) {
	$win = "B";
    }
    return $win;
}

sub proc(@m) {
    print "Input: ( ";
    foreach (@m) {
	print "[", join(",", @$_), "] ";
    }
    say ")";
    say "Output: ", winner(@m);
}

my @moves = ([0,0],[2,0],[1,1],[2,1],[2,2]);
proc(@moves);
@moves = ([0,0],[1,1],[0,1],[0,2],[1,0],[2,0]);
proc(@moves);
@moves = ([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]);
proc(@moves);
@moves = ([0,0],[1,1]);
proc(@moves);
@moves = ([1,1],[0,0],[2,2],[0,1],[1,0],[0,2]);
proc(@moves);

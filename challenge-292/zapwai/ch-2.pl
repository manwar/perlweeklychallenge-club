use v5.38;

# (Unfinished)

# return indices of the color b in board
sub ball_locate($board, $b) {
    my @list;
    my @B = split "", $board;
    for my $i (0 .. $#B) {
	if ($B[$i] eq $b) {
	    if ($i == 0) {
		push @list, $i;
	    } else {
		my $v = $i - 1;
		push @list, $i unless (grep /$v/, @list);
	    }
	}
    }
    return @list;
}

# remove blocks of 3+ identical chars (Zuma wash)
sub wash($s) {
    while ($s =~ /(\w)\1\1/) {
	say $s;
	$s =~ s/(\w)\1\1+//g;
    }
    return $s;
}

sub proc($board, $hand) {
    say "Input: \$board = $board, \$hand = $hand";
    $hand = join "", sort split "", $hand;
    my %g;
    # keys are ball combinations used e.g. RB means two turns have passed
    # value is the state of the board after a Zuma "wash"
    
    my $lvl = 0;
    my @g;
    $g[$lvl++] = $board;
    while ($lvl > 0) {
	my @ball = split "", $hand;
	my @done;	     # We use one ball of each color per round
	
	foreach my $b (@ball) {
	    next if (grep /$b/, @done);
	    push @done, $b;
	    my @l = ball_locate($board, $b);
	    my $strip = "";	# list of outputs, sep by space
	    $strip .= substr($board, 0, $_) . $b . substr($board, $_) . " " for (@l);
	    say "s: $strip";
	    $g[$lvl] .= wash($strip);
	}
	say $g[$lvl++];
	$lvl = 0 if $lvl == 2;
    }
    say "Output: $lvl";
}

my $board = "WRRBBW"; my $hand = "RB";
proc($board, $hand);
$board = "WWRRBBWW"; $hand = "WRBRW";
#proc($board, $hand);
$board = "G"; $hand = "GGGGG";
#proc($board, $hand);

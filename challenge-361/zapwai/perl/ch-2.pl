use v5.38;

sub proc(@party) {
    say "Input: ";
    my @candidate;
    
    # Knows nobody
    for my $i (0 .. $#party) {
	my $r = $party[$i];
	say "\t@$r";
	my $sum = 0;
	for my $val (@$r) {
	    $sum += $val;
	}
	push @candidate, $i if ($sum == 0);
    }

    # Everyone knows them
    my @celeb;
    for my $i (@candidate) {
	my $sum = 0;
	for my $j (0 .. $#party) {
	    next if ($j == $i);
	    $sum++ if (${$party[$j]}[$i] == 1); # ??
	}
	push @celeb, $i if ($sum == $#party);
    }

    print "Output: ";
    if (@celeb) {
	say "@celeb";
    } else {
	say "-1";
    }
}

my @party = (
    [0, 0, 0, 0, 1, 0],		# 0 knows 4
    [0, 0, 0, 0, 1, 0],		# 1 knows 4
    [0, 0, 0, 0, 1, 0],		# 2 knows 4
    [0, 0, 0, 0, 1, 0],		# 3 knows 4
    [0, 0, 0, 0, 0, 0],		# 4 knows NOBODY
    [0, 0, 0, 0, 1, 0],		# 5 knows 4
);
proc(@party);

@party = (
    [0, 1, 0, 0],		# 0 knows 1
    [0, 0, 1, 0],		# 1 knows 2
    [0, 0, 0, 1],		# 2 knows 3
    [1, 0, 0, 0]		# 3 knows 0
);
proc(@party);

@party = (
    [0, 0, 0, 0, 0],		# 0 knows NOBODY
    [1, 0, 0, 0, 0],		# 1 knows 0
    [1, 0, 0, 0, 0],		# 2 knows 0
    [1, 0, 0, 0, 0],		# 3 knows 0
    [1, 0, 0, 0, 0]		# 4 knows 0
);
proc(@party);

@party = (
    [0, 1, 0, 1, 0, 1],		# 0 knows 1, 3, 5
    [1, 0, 1, 1, 0, 0],		# 1 knows 0, 2, 3
    [0, 0, 0, 1, 1, 0],		# 2 knows 3, 4
    [0, 0, 0, 0, 0, 0],		# 3 knows NOBODY
    [0, 1, 0, 1, 0, 0],		# 4 knows 1, 3
    [1, 0, 1, 1, 0, 0]		# 5 knows 0, 2, 3
);
proc(@party);

@party = (
    [0, 1, 1, 0],		# 0 knows 1 and 2
    [1, 0, 1, 0],		# 1 knows 0 and 2
    [0, 0, 0, 0],		# 2 knows NOBODY
    [0, 0, 0, 0]		# 3 knows NOBODY
);
proc(@party);

@party = (
    [0, 0, 1, 1],		# 0 knows 2 and 3
    [1, 0, 0, 0],		# 1 knows 0
    [1, 1, 0, 1],		# 2 knows 0, 1 and 3
    [1, 1, 0, 0],		# 3 knows 0 and 1
);
proc(@party);

use v5.38;

#increment a location in the matrix
sub boom($ref, $x, $y, $row, $col) {
    for my $i (0 .. $row - 1) {
	$$ref[$i][$y]++;
    }
    
    for my $j (0 .. $col - 1) {
	$$ref[$x][$j]++;
    }
}

sub proc($row, $col, @locations) {
    print "Input: \$row = $row \$col = $col \@locations = ( ";
    print "[".join(",", @$_)."] " foreach (@locations);
    say ")";

    #Initialize matrix
    my @a;
    for my $i (0 .. $row - 1) {
	for my $j (0 .. $col - 1) {
	    $a[$i][$j] = 0;
	}
    }

    #Advance matrix at each location
    for my $loc (@locations) {
	my ($x, $y) = @$loc;
	boom(\@a, $x, $y, $row, $col);
    }
    
    #Display matrix!
    say "Final: ";
    my $o = 0;
    for my $i (0 .. $row - 1) {
	print " ";
	for my $j (0 .. $col - 1) {
	    my $a = $a[$i][$j];
	    print $a;
	    $o++ if ($a%2==1);
	}
	say "";
    }
    
    say "Output: $o";
}

my $row = 2; my $col = 3; my @locations = ([0,1],[1,1]);
proc($row, $col, @locations);
$row = 2; $col = 2; @locations = ([1,1],[0,0]);
proc($row, $col, @locations);
$row = 3; $col = 3; @locations = ([0,0],[1,2],[2,1]);
proc($row, $col, @locations);
$row = 1; $col = 5; @locations = ([0,2],[0,4]);
proc($row, $col, @locations);
$row = 4; $col = 2; @locations = ([1,0],[3,1],[2,0],[0,1]);
proc($row, $col, @locations);


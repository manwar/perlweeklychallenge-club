use v5.38;
my $matrix = [['x', 'x', 'x', 'x', 'o'],
	      ['x', 'o', 'o', 'o', 'o'],
	      ['x', 'o', 'o', 'o', 'o'],
	      ['x', 'x', 'x', 'o', 'o'],
	  ];
proc($matrix);
$matrix = [['x', 'x', 'x', 'x', 'x'],
	   ['x', 'o', 'o', 'o', 'o'],
	   ['x', 'x', 'x', 'x', 'o'],
	   ['x', 'o', 'o', 'o', 'o'],
       ];
proc($matrix);
$matrix = [['x', 'x', 'x', 'o', 'o'],
	   ['o', 'o', 'o', 'x', 'x'],
	   ['o', 'x', 'x', 'o', 'o'],
	   ['o', 'o', 'o', 'x', 'x'],
       ];
proc($matrix);

# Return true if these strings share an item
sub intersection($a, $b) {
    for my $entry1 (split " ", $a) {
	for my $entry2 (split " ", $b) {
	    if ($entry1 eq $entry2) {
		return 1;
	    }
	}
    }
    return 0;
}

# Final processing step, any intersecting blocks are merged into one block.
sub merge($c) {
    for my $i1 (0 .. $#{$c} - 1) {
	for my $i2 ($i1 + 1 .. $#{$c}) {
	    if (intersection($$c[$i1], $$c[$i2])) {
		my %h;
		$h{$_} = 1 for (split " ", $$c[$i1]);
		$h{$_} = 1 for (split " ", $$c[$i2]);
		$$c[$i1] = "";
		$$c[$i2] = join(" ", sort keys %h);
	    }
	}
    }
}

# From top left to bottom right, beginning at given entry
# pushes a block to the main contiguous array, @contig
sub contig($matrix, $m, $n, $entry, $c) {
    my @blocks = ($entry);
    for my $block (@blocks) {
	my ($y, $x) = split "-", $block;
	if ($x + 1 <= $n) {
	    if ($$matrix[$y][$x] eq $$matrix[$y][$x+1]) {
		push @blocks, "$y-".($x+1);
	    }
	}
	if ($y + 1 <= $m) {
	    if ($$matrix[$y][$x] eq $$matrix[$y+1][$x]) {
		push @blocks, ($y+1)."-$x";
	    }
	}
    }
    push @$c, join(" ", @blocks);
}

# e.g. @blocks = ("0-0 0-1 0-2"  "1-1 1-2 1-3")
# For each cell in a block, check right/down, then add to the current block
sub proc($matrix) {
    say "Input: \$matrix = ";
    say "\t@{$_}" for (@$matrix);
    my $m = -1 + @$matrix;
    my $n = -1 + @{$$matrix[0]};
    my @contig;
    contig($matrix, $m, $n, "0-0", \@contig);
    for my $i (0 .. $m) {
	for my $j (0 .. $n) {
	    my $got_flag = 0;
	    my $entry = "$i-$j";
	    for my $b (@contig) {
		$got_flag = 1 if (grep /$entry/, split(" ", $b));
	    }
	    contig($matrix, $m, $n, $entry, \@contig) unless ($got_flag);
	}
    }
    merge(\@contig);
    say "";
    my $cnt = 0;
    for my $c (@contig) {
	if ($c) {
	    say $c;
	    my $len = scalar split " ", $c;
	    $cnt = $len if ($cnt < $len);
	}
    }
    say "\nOutput: $cnt\n";
}


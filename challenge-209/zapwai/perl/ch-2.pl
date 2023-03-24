use v5.30.0;
no warnings;
my @accounts = [ ["A", "a1\@a.com", "a2\@a.com"],
		 ["B", "b1\@b.com"],
		 ["A", "a3\@a.com", "a1\@a.com"] ];
my @A = @{$accounts[0]};
# Display Input
say "Input:";
for my $i (0 .. $#A) {
    for my $j (0 .. $#{$A[$i]}) {
	print $A[$i][$j]." ";
    }
    say ;
}
# Search rows for matching email data.
for my $i (0 .. $#A - 1) {
    for my $i2 ($i+1 .. $#A) {
	next if ($A[$i][0] ne $A[$i2][0]);
	foreach my $j (1 .. $#{$A[$i]}) {
	    foreach my $j2 (1 .. $#{$A[$i2]}) {
		next if ($A[$i][$j] ne $A[$i2][$j2]);
		#It's mergin' time!
		#Push all of row i2 entries onto row i, then remove row i2.
		foreach my $k (1 .. $#{$A[$i2]}) {
		    push @{$A[$i]}, $A[$i2][$k];
		}
		splice @A, $i2, 1;
	    }
	}
    }
}
# Remove duplicates
for my $i (0 .. $#A) {
    my @list;
    for my $j (1 .. $#{$A[$i]}) {
	next if ( $A[$i][$j] ~~ @list);
	push @list, $A[$i][$j];
    }
    splice @{$A[$i]}, 1;
    push @{$A[$i]}, @list;
}
# Display Output
say "\nOutput:";
for my $i (0 .. $#A) {
    for my $j (0 .. $#{$A[$i]}) {
	print $A[$i][$j]." ";
    }
    say "";
}

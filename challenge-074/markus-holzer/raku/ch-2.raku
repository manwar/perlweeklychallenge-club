my $S = ‘ababc’;
.say for ( [\,] $S.comb ).map( -> $L { 
	my $B = $L.Bag;
	$L.first({ $B{ $_ } == 1 }) || "#"
});
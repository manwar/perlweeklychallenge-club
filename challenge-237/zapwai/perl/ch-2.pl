use v5.30;
my @nums = (1, 3, 5, 2, 1, 3, 1);
say "Input: \@nums  = (" . join(", ",@nums) . ")";
my %loc;
for my $i (0 .. $#nums) {
    if ($loc{$nums[$i]}) {
	my @list = @{$loc{$nums[$i]}};
	push @list, $i;
	$loc{$nums[$i]} = \@list;
    } else {
	$loc{$nums[$i]} = [$i];
    }
}
my @perm;
my @tube = sort { $a <=> $b } @nums;
my @value = reverse sort { $a <=> $b }  keys %loc;
foreach my $i (@{$loc{$value[0]}}) {
    $perm[$i] = shift @tube;
}
shift @value;
for my $j (@value) {
    foreach my $i (@{$loc{$j}}) {
	if ($nums[$i] < $tube[$#tube]) {
	    $perm[$i] = pop @tube;
	}
	else {
	    $perm[$i] = shift @tube;	    
	}
    }
}
my $cnt;
foreach my $i (0 .. $#nums) {
    $cnt++ if ($nums[$i] < $perm[$i]);
}
say "Output: $cnt \n\t\t(".join(", ",@perm).")";

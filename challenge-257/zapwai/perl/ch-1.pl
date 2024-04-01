use v5.36;
sub proc(@a) {
    my @f = (0) x @a;
    for my $i (0 .. $#a) {
	for my $j (0 .. $#a) {
	    $f[$i]++ if ($a[$i] > $a[$j]);
	}
    }
    say "Input: \@a = (" . join(", ", @a) . ")";
    say "Output: \@f = (" . join(", ", @f) . ")";
}

my @a = (5,2,1,6);
proc(@a);

@a = (1, 2, 0, 3);
proc(@a);

@a = (0, 1);
proc(@a);

# Test: perl6 ch-1.p6
sub MAIN() {
	my @out;
	my @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8);
	my $S = 3;

	for (2 .. @A.elems - 1) -> $i {
		push @out, min @A[$i], @A[$i - 1], @A[$i - 2];
	}

	say '(' ~ @out.join(", ") ~ ')';
}

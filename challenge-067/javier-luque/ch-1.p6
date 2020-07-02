# Test: perl6 ch-1.p6
multi MAIN() { MAIN(5, 2); }

multi MAIN(Int $m, Int $n) {
	my @data = (1 .. $m);
	say @data.combinations: $n;
}

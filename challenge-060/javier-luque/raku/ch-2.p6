# Test: perl6 ch-2.p6
sub MAIN() {
    my @L = (0, 1, 2, 5);
    my $X = 2;
    my $Y = 21;
    my @answers;

    # Brute force the variations
    my @combos = @L.combinations: $X;
    for @combos -> $combo {
    	for $combo.permutations -> $perms {
    		my $n = $perms.join('').Int;
    		@answers.push($n)
    			if ($n < $Y && $n.chars == $X);
    	}
    }

    say @answers.sort.join(', ');
}

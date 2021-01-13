# Test: perl6 ch-2.p6
multi MAIN { MAIN(2) };

multi MAIN(Int $size) {
    # Generate the possible combinations
    my @vowels;
    push @vowels, 'a', 'e', 'i', 'o', 'u'
    	for (1 .. $size);
    my @combos = @vowels.combinations: $size;

    # Check each combination
    my @solutions;
    for @combos.unique -> @combo {
    	push @solutions, @combo.join
    		if (valid-combination(@combo));
    }

    # Print the solutions
    .say for @solutions.unique.sort;
}

# IS valid combination
sub valid-combination(@word) {
    # Faster than a regex
    loop (my $i = 0; $i < @word.elems - 1; $i++) {
    	return 0 unless
    		_check-letters(@word, $i, 'a', ['e','i']) &&
    		_check-letters(@word, $i, 'e', ['i']) &&
    		_check-letters(@word, $i, 'i', ['a', 'e', 'o', 'u']) &&
    		_check-letters(@word, $i, 'o', ['a', 'u']) &&
    		_check-letters(@word, $i, 'u', ['o', 'e']);
    }

    return 1;
}

# Check the folowing letters
sub _check-letters(@word, Int $i, $letter, @checks) {
    my $valid = True;

    if (@word[$i] eq $letter) {
    	$valid = False;
    	for (@checks) -> $check {
    		$valid = True
    			if (@word[$i + 1] eq $check);
    	}
    }

    return $valid;
}

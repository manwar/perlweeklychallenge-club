# Test: perl6 ch-1.p6

# Phone key transations
my %phone_keys = (
	'1' => ['_', ',', '@'],
	'2' => ['a', 'b', 'c'],
	'3' => ['d', 'e', 'f'],
	'4' => ['g', 'h', 'i'],
	'5' => ['j', 'k', 'l'],
	'6' => ['m', 'n', 'o'],
	'7' => ['p', 'q', 'r', 's'],
	'8' => ['t', 'u', 'v'],
	'9' => ['w', 'x', 'y', 'z'],
	'*' => ['_'],
	'0' => [''],
	'#' => [''],
);

multi MAIN() { MAIN('35'); }

multi MAIN(Str $S) {
	# Output the answer
	say combos($S).perl;
}

# Generate the possible combinations
sub combos(Str $S) {
	my @answers;

	my $letter = $S.substr(0, 1);
	my $rest_of_word = $S.substr(1);

	for (@(%phone_keys{$letter})) -> $l {
		if ($rest_of_word) {
			my @partial_answers =
				combos($rest_of_word);
			@answers.append(@partial_answers.map({ $l ~ $_ }));
		} else {
			@answers.append($l);
		}
	}

	return @answers;
}

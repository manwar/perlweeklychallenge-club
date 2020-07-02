#!/usr/bin/perl
# Test: ./ch-2.pl
use Modern::Perl;

# Default $m and $n
my $S = shift // '35';

# Phone key transations
my $phone_keys = {
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
};

# Output the answer
say
	'[ "' .
	( join '", "',
		combos($S)
	) .
	'" ]';

# Generate the possible combinations
sub combos {
	my $S = shift;
	my @answers;

	my ($letter, $rest_of_word) =
		split('',$S,2);

	for my $l (@{$phone_keys->{$letter}}) {
		if ($rest_of_word) {
			my @partial_answers =
				combos($rest_of_word);

			push @answers,
				map { $l . $_}
				@partial_answers;
		} else {
			push @answers, $l;
		}
	}

	return @answers;
}

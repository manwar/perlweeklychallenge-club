use v5.24;
use warnings;

sub match_words
{
	my ($string, @words) = @_;
	@words = sort { length $b <=> length $a } @words;

	my @found;

	WORD_LOOP:
	while (length $string > 0) {
		for my $word (@words) {

			if (substr($string, 0, length $word) eq $word) {
				$string = substr $string, length $word;
				push @found, $word;
				next WORD_LOOP;
			}
		}

		last;
	}

	return 0 if @found != @words;
	return
		join ", ",
		map { '"' . $_ . '"' }
		@found
	;
}

use Test::More;

my @data = (
	[
		"perlweeklychallenge",
		[qw(weekly challenge perl)],
		'"perl", "weekly", "challenge"',
	],
	[
		"perlandraku",
		[qw(python ruby haskell)],
		0,
	],
	[
		"perlandraku",
		[qw(perl raku)],
		0,
	],
	[
		"perlishperl",
		[qw(perl perlish)],
		'"perlish", "perl"',
	],
	[
		"",
		[],
		"",
	],
	[
		"",
		[qw(test)],
		0,
	],
);

for (@data) {
	my ($string, $words, $output) = @$_;
	is match_words($string, @$words), $output, "string match ok";
}

done_testing;

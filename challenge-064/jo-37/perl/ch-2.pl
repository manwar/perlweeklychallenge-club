#!/usr/bin/perl

use Test2::V0;

# Set to true to display intermediate variables
my $verbose;

# First arg: string to be split
# Remaining args: word list
# Try to split string into words.
# call: matchwords $S, @W
sub matchwords {
	local $_= shift;

	# Generate regex matching and capturing any of the given words.
	# This will look like qr/(?|(word1)|(word2)|.../
	my $any = sub {local $" = '|'; qr/(?|@_)/ }->(
		map "(@{[quotemeta]})",
		sort {length $b <=> length $a} @_);
	print "$any\n" if $verbose;

	my @matched;
	local our @match;

	# Split string into given words, saving captured parts on the way.
	m/
		^
		(?{ @match = () })	# Reset match at start of string.
		(?:
			$any			# Match and capture a word.
							# Save matched word, backtracking-safe.
			(?{local @match = @match; push @match, $1 })
		)+
		$
							# Full match: Copy matched words
							# from temporary to persistent variable.
		(?{ @matched = @match })

	/x;

	@matched;
}

# Testdata:
# $S: string to be split
# @W: words to be used for splitting
# @R: expected result
# $C: Comment
my @testdata = (
	# [$S, [@W], [@R], $C],
	['perlweeklychallenge', [qw(weekly challenge perl)],
		[qw(perl weekly challenge)], '1st example'],
	['perlandraku', [qw(python ruby haskell)],
		[], '2nd example'],
	['startismissing', [qw(is missing)], [], 'start word is missing'],
	['endismissing', [qw(is end)], [], 'end word is missing'],
	['middleismissing', [qw(missing middle)], [], 'middle word is missing'],
	['some.*regex[a-z]inthe?string', [qw(.* [a-z] the? in regex some string)],
		[qw(some .* regex [a-z] in the? string)],
		'string and words contain regex meta chars'],
	['thelongerwordmatches', [qw(long erwordm atch matches longer word the)],
		[qw(the longer word matches)], 'longer word matches'],
	['theshorterwordmatches', [qw(shorter erwordm atches match short word the)],
		[qw(the short erwordm atches)], 'backtrack to shorter word'],
);

#$verbose = 1;

plan scalar @testdata;
for my $test (@testdata) {
	my ($string, $words, $result, $comment) = @$test;
	my @result = matchwords($string, @$words);
	is \@result, $result, $comment;
}

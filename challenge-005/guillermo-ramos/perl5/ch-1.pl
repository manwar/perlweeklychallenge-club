#!/usr/bin/env perl

use strict;
use warnings;

sub anagrams {
	# Tail-recursive with accumulator; iterate over the word accumulating the
	# anagrams that can be formed with the already-seen characters
	sub iter {
		# @acc contains the already computed anagrams
		my ($word, @acc) = @_;
		if (length($word) == 0) {
			# Finished consuming word -> return accumulator
			return @acc;
		} else {
			# Split the current word: first letter vs the rest
			my ($head, $tail) = $word =~ /^(.)(.*)$/;
			@_ = $tail; # Next word will be the tail of the previous one
			# Compute new anagrams by inserting the current letter in all the
			# positions of the previous anagrams
			foreach my $anagram (@acc) {
				for (my $i = 0; $i <= length($anagram); $i++) {
					push(@_, $anagram);
					substr($_[-1], $i, 0) = $head;
				}
			}
			goto &iter;
		}
	}
	iter(shift, (""));
}

for (@ARGV) {
	for (anagrams($_)) {
		print $_, "\n";
	}
}

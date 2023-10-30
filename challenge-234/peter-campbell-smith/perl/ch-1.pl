#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-09-11
use utf8;     # Week 234 task 1 - Common characters
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

common_characters('java', 'javascript', 'julia');
common_characters('bella', 'label', 'roller'); 
common_characters('cool', 'lock', 'cook');
common_characters('abcdefffffgh','deffffxudlge', 'jrwtsiffftmhdeff', 'deffxxxxxxx', 'xxexxxdxfxxxxf');
common_characters('abc', 'def', 'ghi');

sub common_characters {
	
	my (@words, $word, $sample, $j, @result, $good);
	
	# sanity check
	@words = @_;
	return if scalar @words < 2;
	
	# sort all words' letters into ascending order
	for $word (@words) {
		$word = join('', sort(split('', lc($word))));
	}
	
	# loop over 'samples' in word 0 - eg a or bbb or cc
	SAMPLE: while ($words[0] =~ m|(.)(\1*)|g) { 
		$sample = $1 . $2;
		while ($sample) {
			
			# check whether the sample appears in all the other words, else go to next sample
			$good = 1;
			for $j (1 .. scalar @words - 1) {
				$good = 0 unless $words[$j] =~ m|$sample|;
				next SAMPLE if (not $good and length($sample) == 1);
			}
			
			# if all the words matched, add the individual characters of sample to the result
			if ($good) {
				push(@result, $1) while $sample =~ m|(.)|g;
				next SAMPLE;
			}
			
			# if eg aaa didn't match, try again with aa then a
			$sample =~ s|.||;
		}
	}
	
	# show results
	say qq[\nInput:  \@words = ('] . join(qq[', '], @_) . q[')];
	say qq[Output: ('] . join(qq[', '], @result) . q[')];
}

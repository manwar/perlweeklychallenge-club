#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-06-05
use utf8;     # Week 220 task 1 - Common characters
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

common_characters('Perl', 'Rust', 'Raku');
common_characters('mouse', 'house', 'esoteric', 'some', 'mesolithic', 'Thames', 'semibreve'); 
common_characters('ring', 'sing', 'ping', 'zing', 'shopping', 'single', 'mingle', 'gin');

sub common_characters {
	
	my (@words, $w, @letters);
	
	# delete from $word[0] any letters not in all the other words
	@words = @_;
	for $w (1 .. scalar @words - 1) {
		$words[0] =~ s|[^$words[$w]]||gi;
	}

	@letters = sort(split('', lc($words[0])));

	# show results
	say qq[\nInput:  \@words = ('] . join(qq[', '], @_) . q[')];
	say qq[Output: ('] . join(qq[', '], @letters) . q[')];
}


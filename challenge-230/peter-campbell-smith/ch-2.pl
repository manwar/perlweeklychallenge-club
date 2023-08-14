#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-08-14
use utf8;     # Week 229 task 2 - Count words
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

count_words(['pay', 'attention', 'practice', 'attend'], 'at');
count_words(['janet', 'julia', 'java', 'javascript'], 'ja');
count_words(['hello', 'hedge', 'he', 'heffalump', 'herbivore', 'lion'], 'he');
count_words(['the', 'cat', 'sat', 'on', 'the', 'mat'], 'zzz');
count_words(['ping', 'pong', 'pint', 'punt', 'pine'], 'pin');

sub count_words {
	
	my ($w, @matches);
	
	# add any word that matches to @matches
	@matches = ();
	for $w (@{$_[0]}) {
		push(@matches, $w) if $w =~ m|^$_[1]|;
	}
	
	# spill the beans
	say qq[\nInput:  \@words = ('] . join(qq[', '], @{$_[0]}) . qq['), \$prefix = '$_[1]'];
	say qq[Output: ] . ($#matches + 1) .
		(@matches ? (qq[ - '] . join(qq[', '], @matches) . qq[']) : '');	
}

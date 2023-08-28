#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-08-07
use utf8;     # Week 229 task 1 - Lexicographic order
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

lexicographic_order('abc', 'bce', 'cae');
lexicographic_order('yxz', 'cba', 'mon');
lexicographic_order('abc', 'def', 'xyz');
lexicographic_order('zyx', 'wus', 'cba');
lexicographic_order(qw(now is the time for all good men to come to the aid of the party));

sub lexicographic_order {
	
	my (@bad, $string);
	
	# find any strings that don't change if sorted lexicographically
	for $string (@_) {
		push(@bad, $string) 
			if ($string ne join('', sort(split('', $string)))
			and $string ne join('', reverse sort(split('', $string))));
	}
	
	# show results
	say qq[\nInput:  \@str = (']. join(qq[', '], @_) . qq[')];
	say qq[Output: ] . (scalar @bad);
	say qq[   Disordered: ('] . join (qq[', '], @bad) . qq[')] if @bad;
}
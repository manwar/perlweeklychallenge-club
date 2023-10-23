#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-10-16
use utf8;     # Week 239 task 2 - Consistent strings
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

consistent_strings(['ad', 'bd', 'aaab', 'baa', 'badab'], 'ab');
consistent_strings(['a', 'b', 'c', 'ab', 'ac', 'bc', 'abc'], 'abc');
consistent_strings(['cc', 'acd', 'b', 'ba', 'bac', 'bad', 'ac', 'd'], 'cad');
consistent_strings(['perl', 'is', 'an', 'easy', 'language', 'to', 'use'], 'aegilnoprstuy');
consistent_strings(['perl', 'is', 'an', 'easy', 'language', 'to', 'use'], 'bcdfhjkmqvwxz');
	
sub consistent_strings {
	
	my (@strings, $allowed, $j, $count);
	
	$count = 0;
	@strings = @{$_[0]};
	$allowed = $_[1];
	
	# increment $count if $strings[$j] is conprised only from the letters in $_[1] (= allowed)
	for $j (0 .. @strings - 1) {
		$count ++ if $strings[$j] =~ m|^[$allowed]+$|;
	}

	say qq[\nInput:  \@str = ('] . join(q[', '], @strings) . q[')];
	say qq[        \$allowed = '$_[1]'];
	say qq[Output: $count];	
}
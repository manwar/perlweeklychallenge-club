#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-06-30
use utf8;     # Week 328 - task 2 - Good string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

good_string('WeEeekly');
good_string('abcddeFfgghH');
good_string('goodstringsGOODSTRINGS');
good_string('BbaADdsSTtrRIinNGg');

sub good_string {
	
	my (@string, $p, @new_string, $last_p);
	
	# initialise
	@string = split('', $_[0]);
	$p = 0;
	$last_p = $#string;
	
	# move partition along
	while (1) {
		
		# finished
		last if $p >= $#string;
		
		# pair at p, p + 1 is bad, cut them out and move partition left
		if (is_bad($string[$p], $string[$p + 1])) {
			@new_string = ();
			@new_string = @string[0 .. $p - 1] if $p > 0;
			@new_string = (@new_string, @string[$p + 2 .. $#string]) if $p + 2 <= $#string;
			@string = @new_string;
			$p -- if $p > 0;
			
		# pair at p, p + 1 is good - move partition right
		} else {
			$p ++;
		}
	}			
	
	say qq[\nInput:  '$_[0]'];
	say qq[Output: '] . join('', @string) . q['];
}

sub is_bad {
	
	# good unless they are the same character
	return 0 unless lc($_[0]) eq lc($_[1]);
	
	# bad if they are Xx or xX
	return 1 if $_[0] le 'Z' and $_[1] ge 'a' or
				$_[0] ge 'a' and $_[1] le 'Z';
	
	# otherwise good (xx or XX)
	return 0;
}

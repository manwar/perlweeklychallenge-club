#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-04-20
use utf8;     # Week 370 - task 2 - Scramble string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

scramble_string('abc', 'acb');
scramble_string('abcd', 'cdba');
scramble_string('ateer', 'eater');
scramble_string('abcd', 'bdac');
scramble_string('csaerlmb', 'scramble');
scramble_string('aiontctunup', 'punctuation');
scramble_string('itsappointmedn', 'disappointment');

sub scramble_string {
	
	my (@string, $length, $split, @part0, @chars0, @chars1, $x, $j,
		$iter0, $iter1, @part1);
	
	# initialise and check validity
	@string = @_;
	say qq[\nInput:  \$string1 = '$string[0]'];
	say qq[        \$string2 = '$string[1]'];
	$length = length($string[0]);
	
	# validity check
	if ($length != length($string[1]) or $length == 0) {
		say qq[Output: false - strings must be of equal non-zero length];
		return;
	} elsif (sort_string($string[0]) ne sort_string($string[1])) {
		say qq[Output: false - strings must contain same characters];
		return;		
	} elsif ($length == 1) {
		say qq[Output: true ('$string[0]')];
		return;
	}
	
	# loop over split points
	for $split (0 .. $length - 2) {
		$part0[0] = substr($string[0], 0, $split + 1);
		$part0[1] = substr($string[0], $split + 1);
		
		# exchange or don't exchange parts
		for (0 .. 1) {
			if ($_) {
				$x = $part0[0];
				$part0[0] = $part0[1];
				$part0[1] = $x;
			}

			# now split $string[1] like $string[0]
			$part1[0] = substr($string[1], 0, length($part0[0]));
			$part1[1] = substr($string[1], length($part0[0]));
			
			# compare the left parts 
			if (sort_string($part0[0]) eq sort_string($part1[0])) {
				say qq[Output: true ('$part1[0]' . '$part1[1]')];
				return;
			}
		}
	}
	say qq[Output: false];
}

sub sort_string {
	return join('', sort {$a cmp $b} split('', $_[0]));
}

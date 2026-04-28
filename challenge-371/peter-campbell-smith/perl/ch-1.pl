#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-04-27
use utf8;     # Week 371 - task 1 - Missing letter
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

missing_letter(qw(? m b n c));
missing_letter(qw(b ? c b d));
missing_letter(qw(a c ? g i));
missing_letter(qw(a c e ? i));
missing_letter(qw(m a n b ?));
missing_letter(qw(z y x w ?));
missing_letter(qw(o o ? o o));

sub missing_letter {
	
	my (@q, $a, $b, $j, $qm, $gap, $char);
	
	# initialise
	@q = @_;
	
	# find the pairs (see blog)
	for $j (0 .. 3) {
		if ($q[$j] =~ m|[a-z]| and $q[$j + 1] =~ m|[a-z]|) {
			$gap = ord($q[$j + 1]) - ord($q[$j]);
			if ($j & 1) { $b = $gap } else { $a = $gap };
			
		# and the '?'
		} else {
			$qm = $j;
		}
	}
	$qm = 4 if $q[4] eq '?';
	
	# deduce the missing char
	$char = $qm == 0 ? chr(ord($q[1]) - $a) : chr(ord($q[$qm - 1]) + ($qm & 1 ? $a : $b));

	say qq[\nInput:  ] . join(' ', @q);	
	say qq[Output: ? = $char; sequence = ] . sprintf('%+d, %+d; ', $a, $b);
}

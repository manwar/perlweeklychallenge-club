#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-05-25
use utf8;     # Week 375 - task 2 - Find K-Beauty
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

find_KBeauty(240, 2);
find_KBeauty(1001, 2);
find_KBeauty(100100, 4);
find_KBeauty(2001600, 5);
find_KBeauty(10250, 2);
find_KBeauty(160320, 2);
find_KBeauty(1015050, 3);

sub find_KBeauty {
	
	my ($number, $k, $l, $sub, @subs, $s);
	
	# initialise
	($number, $k) = @_;
	$l = length($number);
	
	# loop over substrings and test for beauty
	for $s (0 .. $l - $k) {
		$sub = substr($number, $s, $k);
		next unless $sub > 0;
		push @subs, $sub if $number / $sub == int($number / $sub);
	}
	
	# report	
	say qq[\nInput:  \$number = $number, \$k = $k];
	say qq[Output: ] . scalar @subs .
		(scalar @subs ? q[ - ] . join(q[, ], @subs) : '');
}

#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-04-06
use utf8;     # Week 368 - task 1 - Make it bigger
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

make_it_bigger(15456, 5);
make_it_bigger(7332, 3);
make_it_bigger(2231, 2);
make_it_bigger(543251, 5);
make_it_bigger(1921, 1);

sub make_it_bigger {
	
	my ($number, $digit, $largest);
	
	# initialise
	($number, $digit) = @_;
	$largest = 0;

	# delete successive occurrences of $digit
	while ($number =~ m|($digit)|g) {
		$largest = qq[$`$'] if qq[$`$'] > $largest;
	}

	# report
	say qq[\nInput:  \$str = $number, \$char = $digit];
	say qq[Output: $largest];
}

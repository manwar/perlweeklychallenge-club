#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-07-14
use utf8;     # Week 330 - task 1 - Clear digits
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

clear_digits('cab12');
clear_digits('xy99');
clear_digits('pa1erl');
clear_digits('onlyletters');
clear_digits('12345');
clear_digits('sausage1234567x');
clear_digits('chxy53f7occ 93oỸ4laps$393tt6ee0');

sub clear_digits {
	
	my ($string);
	
	# initialise
	$string = shift;
	say qq[\nInput:  '$string'];
	
	# do it
	$string = $1 . $2 while $string =~ m|^(.*)[^0-9][0-9](.*)$|;

	# say it
	say qq[Output: '$string'];
}

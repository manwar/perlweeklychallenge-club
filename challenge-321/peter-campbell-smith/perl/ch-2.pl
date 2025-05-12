#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-05-12
use utf8;     # Week 321 - task 2 - Backspace compare
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

backspace_compare('ab#c', 'ad#c');
backspace_compare('ab##', 'a#b#');
backspace_compare('same', 'same');
backspace_compare('#same', '#same');
backspace_compare('a#b', 'c');
backspace_compare('the curfewww## tolls the knelllll### of paaaaa####rting day', 
				  'z#the curfew tollxx##s the knell ofzzz### parting dayw#');

sub backspace_compare {
	
	my ($string1, $string2, $z, $s);
	
	# initialise
	($string1, $string2) = @_;
	say qq[\nInput:  \$string1 = '$string1',\n        \$string2 = '$string2'];
	
	# repeatedly delete backspace and preceding character
	for $s ($string1, $string2) {
		$z = 1;
		$z = ($s =~ s|.#||) while $z;
	}
	
	# report
	say qq[Output: ] . ($string1 eq $string2 ? qq[true -     '$string1'] : 
		qq[false -    '$string1' vs '$string2']);
}

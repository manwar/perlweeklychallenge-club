#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-02-09
use utf8;     # Week 360 - task 1 - Text justifier
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

text_justifier('Code', 10);
text_justifier('Toad', 11);
text_justifier('Road', 4);
text_justifier('Mode', 20);
text_justifier('Node', 21);
text_justifier('Bode', 5);
text_justifier('', 1);
text_justifier('', 0);

sub text_justifier {
	
	my ($string, $width, $length, $asterisks, $left, $output);
	
	# initialise
	($string, $width) = @_;
	say qq[\nInput:  \$string = '$string', \$width = $width];
	
	# how many asterisks?
	$asterisks = $width - length($string);
	
	# we can do it
	if ($asterisks >= 0) {
		$left = int($asterisks / 2);
		say qq[Output: ] . ('*' x $left) . $string . ('*' x ($asterisks - $left));
		
	# but not if the string won't fit
	} else {
		say qq[Output: Error: string is longer than width];
	}
}

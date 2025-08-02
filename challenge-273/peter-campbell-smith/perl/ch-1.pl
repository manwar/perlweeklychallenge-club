#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-06-10
use utf8;     # Week 273 - task 1 - Percentage of character
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

percentage_of_character('the cat sat on the mat', 'a');
percentage_of_character('percentage of character', 'g');
percentage_of_character('the weekly challenge', 'z');
percentage_of_character('zzzzzzzzzzzzzzzzzz', 'z');

sub percentage_of_character {
	
	my ($str, $char, $chars);
	
	# remove $char from $str
	($str, $char) = @_;
	$chars = $str;
	$chars =~ s|[^$char]+||g;
	
	say qq[\nInput:  \$str = '$str', \$char = '$char'];
	say qq[Output: ] . int(length($chars) / length($str) * 100 + 0.5);
}

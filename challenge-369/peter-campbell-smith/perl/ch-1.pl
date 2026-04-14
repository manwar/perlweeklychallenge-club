#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-04-13
use utf8;     # Week 369 - task 1 - Valid tag
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

valid_tag('Cooking with 5 ingredients!');
valid_tag('the-last-of-the-mohicans');
valid_tag('  extra  spaces  here  ');
valid_tag('!! iPhone 15 Pro Max Review !!');
valid_tag('Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!');

sub valid_tag {
	
	my ($text);
	
	# initialise
	$text = $_[0];
	say qq[\nInput:  '$text'];
	
	$text = lc($text);             # lower case all
	$text =~ s|[^a-z\s]||g;        # remove non-letters
	$text =~ s|^\s+||g;            # no initial spaces
	$text =~ s| ([a-z])|uc($1)|ge; # ucase space+letter
	$text =~ s|\s+||g;			   # no spaces
	$text = substr('#' . $text, 0, 100); # prefix '#'
	                               # and max 100 chars	
	say qq[Output: '$text'];
}

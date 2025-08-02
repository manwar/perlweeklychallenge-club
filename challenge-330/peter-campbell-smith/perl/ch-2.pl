#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-07-14
use utf8;     # Week 330 - task 2 - Title capital
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

title_capital('PERL IS gREAT');
title_capital('THE weekly challenge');
title_capital('YoU ARE A stAR');
title_capital('Der Nobelpreisträger Thomas Südhof spricht über eigene Fehler');

sub title_capital {
	
	my ($string, $new);
	
	# initialise
	$string = shift;
	
	# do what it says
	$new .= length($1) <= 2 ? 
		lc($1) . ' ' : 
		ucfirst(lc($1)) . ' ' 
		while $string =~ m|(\w+)|gu;
	
	# report
	$new = substr($new, 0, -1);
	say qq[\nInput:  '$string'];
	say qq[Output: '$new'];
}

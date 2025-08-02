#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 3 June 2024
use utf8;     # Week 272 - task 2 - String score
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

string_score('hello');
string_score('supercalifragilisticexpialidocious');
string_score('The Weekly Challenge');
string_score('aĐbđcĒeēfĔgĕh🞱');

sub string_score {
	
	my ($score);
	
	$score += abs(ord(substr($_[0], $_, 1)) - 
		ord(substr($_[0], $_ - 1, 1))) 
		for 1 .. length($_[0]) - 1;
	say qq[\nInput:  $_[0]\nOutput: $score];	
}

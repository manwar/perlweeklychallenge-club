#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-03-09
use utf8;     # Week 364 - task 2 - Goal parser
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

goal_parser('G()(al)');
goal_parser('G()()()()(al)');
goal_parser('(al)G(al)()()');
goal_parser('()G()G');
goal_parser('al)(al)G()()');

sub goal_parser {
	
	my ($string, $base);
	
	# initialise
	$string = $_[0];
	say qq[\nInput:  '$string'];
	$base = ord('a') - 1;
	
	# apply rules
	$string =~ s|\(\)|o|g;
	$string =~ s|[\(\)]||g;
	
	say qq[Output: '$string'];
}

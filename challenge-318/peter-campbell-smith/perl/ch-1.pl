#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-04-21
use utf8;     # Week 318 - task 1 - Group position
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

group_position('abccccd');
group_position('aaabcddddeefff');
group_position('abcdd');
group_position('xxxooxoxoxoxooo');
group_position('iiwwiiwwiiwwii');

sub group_position {
	
	my ($string, $result);
	
	$string = shift;
	$result .= qq['$1$2', ] while $string =~ m|(.)(\1\1+)|g;
	
	say qq[\nInput:  '$string'];
	say qq[Output: ] . ($result ? substr($result, 0, -2) : q['']);
}

#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-05-19
use utf8;     # Week 322 - task 1 - String format
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

string_format('ABC-D-E-F', 3);
string_format('A-BC-D-E', 2);
string_format('-A-B-CD-E', 4);

string_format('AAA', 1);
string_format('TEA-TEA-TEA-TEA', 3);
string_format('pe-rlwe-ek03-22ta-sk00-01', 4);
string_format('---', 1);

sub string_format {
	
	my($string, $count, $result);
	
	# initialise
	($string, $count) = @_;
	say qq[\nInput:  \$string = '$string', \$count = $count];
	$result = '';
	
	# get rid of existing '-' characters
	$string =~ s|-||g;
	
	if ($string) {
	
		# add successive groups of final $count letters to $result
		$result = qq[-$1$result] while $string =~ s|(\w{$count})$||g;
		
		# if anything left, add it, else remove leading '-'
		$result = $string ? qq[$string$result] : substr($result, 1);
	}
	say qq[Output: '$result'];
}

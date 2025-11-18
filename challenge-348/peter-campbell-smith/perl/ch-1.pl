#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-11-17
use utf8;     # Week 348 - task 1 - String alike
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

string_alike('rhythm');
string_alike('artifice');
string_alike('MOONSOUP');
string_alike('fairzzzz');
string_alike('uu');
string_alike('aeioupaeioupaeiuopaeioupaeioupaeiuop');
string_alike('123+!£ a $#FF & U (]');

sub string_alike {
	
	my ($string, $output, $size, $half, @count, $c, $h);
	
	# initialise
	$string = $_[0];
	$output = 'false';
	@count = (0, 0);

	# check for even length
	$size = length($string);
	if (($size & 1) == 0) {
		$half = $size / 2;
		$h = 0;
		
		# count vowels
		for $c (0 .. $size - 1) {		
			$h = 1 if $c == $half;
			$count[$h] ++ if substr($string, $c, 1) =~ m|[aeiou]|i;
		}
		
		# check for equality
		if ($count[0] != 0 and $count[0] eq $count[1]) {
			$output = qq[true - $count[0] vowel] . ($count[0] == 1 ? '' : 's');
		}
	}
	
	say qq[\nInput:  '$string'];
	say qq[Output: $output];
}


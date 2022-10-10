#!/usr/bin/perl

# Peter Campbell Smith - 2022-10-10
# PWC 186 task 2

use v5.28;
use utf8;
use warnings;
use charnames ':full';
binmode(STDOUT, ':utf8');

# You are given a string containing characters which may have diacritic marks. Create a subroutine 
# makeover($str) that replaces these characters with their unmarked equivalents.

# Blog: https://pjcs-pwc.blogspot.com/2022/10/merge-like-zip-and-unidecode.html

my (@tests, $test);

@tests = ('ÃÊÍÒÙ', 'âÊíÒÙ', 'ĐđĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħĨĩĪīĬĭĮįİŁłŃńŐőŔŕŖŗŘřŚśŜŝŞş');

# loop over tests
for $test (@tests) {
	say qq[\nInput:  $test\nOutput: ] . makeover($test);
}

sub makeover {
	
	my ($result, $char, $name);

	# loop over characters within test
	while ($_[0] =~ m|(.)|g) {
		$char = $1;
		
		# get Unicode name for character
		$name = charnames::viacode(ord($char));
		
		# check if it is a modified latin letter and if so substitute unmodified letter
		if ($name =~ m|^LATIN CAPITAL LETTER (.)|) {
			$result .= $1;
		} elsif ($name =~ m|^LATIN SMALL LETTER (.)|) {
			$result .= lc($1);
			
		# or if not just copy input to output
		} else {
			$result .= $char;
		}
	}
	return $result;
}
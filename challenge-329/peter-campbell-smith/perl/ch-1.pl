#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-07-07
use utf8;     # Week 329 - task 1 - Counter integers
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

counter_integers('the1weekly2challenge2');
counter_integers('go21od1lu5c7k');
counter_integers('4p3e2r1l');

# longer example
my ($string, $chars);
$chars .= $_ for ('a' .. 'z', '0' .. '9');
$string .= substr($chars, int(rand(36)), 1) for 0 .. 499;
counter_integers($string);

sub counter_integers {
	
	my ($string, $result, $found);
	
	# initialise
	$string = shift;
	say qq[\nInput:  '$string'];
	
	# replace non-digit sequences with blanks
	$string =~ s|[a-z]| |gi;
	
	# create result in original order
	$result = ', ';
	while ($string =~ m|(\d+)|g) {
		$found = $1 + 0;
		if ($result !~ m|, $found,|) {
			$result .= qq[$found, ];
		}
	}
	
	# list them
	say qq[Output: ] . substr($result, 2, -2);
}

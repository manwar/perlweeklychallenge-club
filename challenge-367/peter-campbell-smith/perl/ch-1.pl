#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-03-30
use utf8;     # Week 367 - task 1 - Max odd binary
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

max_odd_binary('000111');
max_odd_binary('100');
max_odd_binary('111000');
max_odd_binary('1111');
max_odd_binary('0101');
max_odd_binary('0000');

sub max_odd_binary {
	
	my ($string, $ones, $zeroes, $result);
	
	# initialise
	$string = $_[0];
	say qq[\nInput:  $string = ] . bin2dec($string);
	
	# count ones and zeroes
	$ones = $string =~ s|1|1|g;
	$zeroes = $string =~ s|0|0|g;
	
	unless ($ones) {
		say qq[Output: impossible - no 1s];
		return;
	}
	
	# make result
	$result = '1' x ($ones - 1) . '0' x $zeroes . '1';
	
	say qq[Output: $result = ] . bin2dec($result);
}

sub bin2dec {
	
	# converts binary string to decimal
	my $result = 0;
	$result = 2 * $result + $_ for split('', $_[0]);
	return $result;
}

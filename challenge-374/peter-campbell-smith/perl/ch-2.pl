#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-05-18
use utf8;     # Week 374 - task 2 - Largest same-digits number
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

largest_samedigits_number('6777133339');
largest_samedigits_number('1200034');
largest_samedigits_number('44221155');
largest_samedigits_number('88888');
largest_samedigits_number('0');
largest_samedigits_number('1');

my $s;   # 500 random digits
$s .= int(rand(10)) for 1 .. 500;
largest_samedigits_number($s);

sub largest_samedigits_number {
	
	my ($string, $largest);
	
	# initialise
	$string = $_[0];
	$largest = 0;
	
	while ($string =~ m|((\d)\2*)|g) {
		$largest = $1 if $1 > $largest;
	}

	say qq[\nInput:  '$string'];
	say qq[Output: '$largest'];
}

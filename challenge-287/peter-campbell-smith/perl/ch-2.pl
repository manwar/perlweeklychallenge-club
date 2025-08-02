#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-09-16
use utf8;     # Week 287 - task 2 - Valid number
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my @tests;

say qq[\nValid numbers:\n      \$str     Valid?\n     -----     ------];
@tests = ('23', '-23', '+23', '34.1', '-34.1', '+34.1', '.7', '-.7', '23e0', '23e-1', '23E+2', '-23e10', '+34.5e-10');
valid_number($_) for @tests;

say qq[\nInvalid numbers:\n      \$str     Valid?\n     -----     ------];
@tests = ('two', '23-', '23.1.2', 'e', 'e1', '34e1.2', '34e++6', '.e5', '+.e5', '123E', '.', '.e6' );
valid_number($_) for @tests;

sub valid_number {
	
	my ($str, $str2, $valid, $a, $b);
	
	$str = $_[0];
	$valid = 0;
	
	# basic match              $a------------  $b-----
	if (($a, $b) = $str =~ m|^([-+]?\d*\.?\d*)([Ee]?.*)$|) {

		# but if [Ee] is present it must be followed by optional sign and 1+ digits
		$valid = 1 if ($b eq '' or ($a ne '' and $b =~ m|^[Ee][-+]?\d+$|));
	}
	
	# decimal point must be preceded or followed by a digit (or both)
	if ($valid and $str =~ m|\.|) {
		$valid = 0 unless ($str =~ m|\d\.| or $str =~ m|\.\d|);
	}
	
	printf("%10s %10s\n", $str, ('false', 'true')[$valid]);
}

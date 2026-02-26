#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-02-23
use utf8;     # Week 362 - task 1 - Echo chamber
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

echo_chamber('xyz');
echo_chamber('hello');
echo_chamber('challenge');
echo_chamber('');
echo_chamber('pi=3.14159');

sub echo_chamber {
	
	my ($input, @chars, $output);
	
	# just do it
	@chars = split('', $_[0]);
	$output .= $chars[$_] x ($_ + 1) for 0 .. $#chars;
		
	say qq[\nInput:  '$_[0]'];
	say qq[Output: '] . (defined $output ? $output : '') . "'";
}

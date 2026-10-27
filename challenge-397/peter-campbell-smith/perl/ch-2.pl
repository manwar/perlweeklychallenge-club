#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/397/2

use v5.26;    # The Weekly Challenge - 2026-10-26
use utf8;     # Week 397 - task 2 - Binary reflection
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

binary_reflection(3, 6, 12);
binary_reflection(1, 2, 4, 8);
binary_reflection(7, 8, 9, 10);
binary_reflection(5, 9, 15, 17);
binary_reflection(11, 13, 14, 19);
binary_reflection(1, 78, 45, 100, 9, 11, 47, 0, 42);
binary_reflection(63, 31, 255, 15, 127, 3);

sub binary_reflection {
	
	my (@array, $j, $revbin, @entries, @sorted, $output);
	
	# convert numbers to binary and reverse those
	@array = @_;
	for $j (0 .. $#array) {
		$revbin = bin2dec('b' . reverse(sprintf('%b', $array[$j])));
		push @entries, sprintf('%09d~%09d', $revbin, $j);
	}
	
	# sort by reversed binary . original index in @array
	@entries = sort {$a cmp $b} @entries;
	for $j (0 .. $#entries) {
		$entries[$j] =~ m|~(\d+)|;
		$output .= $array[$1 + 0] . ', ';
	}
	
	# report
	say qq[\nInput:  (] . join(', ', @array) . ')';
	say qq[Output: (] . substr($output, 0, -2) . ')';
}
	
sub bin2dec {
	
	# converts eg binary string b0101 to decimal 5
	my $input = $_[0];
	$input = substr($input, 1, 99);
	my $result = 0;
	$result = 2 * $result + $_ for split('', $input);
	return $result;
}

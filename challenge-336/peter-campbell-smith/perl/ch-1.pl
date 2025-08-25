#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-08-25
use utf8;     # Week 336 - task 1 - Equal group
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

equal_group(1, 1, 2, 2, 2, 2);
equal_group(1, 1, 1, 2, 2, 2, 3, 3);
equal_group(5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7);
equal_group();
equal_group(42);
equal_group(77, 77);
equal_group(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1);

sub equal_group {
	
	my (@array, $result, $size, $groups, $group, $start, $member, $output);
	
	# initialise
	@array = @_;
	$result = 'false';
	
	# loop down over possible group sizes
	SIZE: for ($size = scalar @array; $size >= 2; $size --) {
		
		# check for integral number of groups
		$groups = scalar @array / $size;
		next SIZE unless $groups == int($groups);
		
		# check each group
		$output = '(';
		for $group (0 .. $groups - 1) {
			$start = $group * $size;
			
			# check each member
			for $member (0 .. $size - 1) {
				next SIZE unless $array[$start + $member] == $array[$start];
				$output .= qq[$array[$start + $member], ];
			}
			$output = substr($output, 0, -2) . '), (';
		}
		$result = qq[true - ] . substr($output, 0, -3);
		last;
	}
	
	say qq[\nInput:  (] . join(', ', @array) . ')';
	say qq[Output: $result];
}

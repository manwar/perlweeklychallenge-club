#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-04-21
use utf8;     # Week 318 - task 2 - Reverse equals
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

reverse_equals([1, 2, 3, 4, 5], [1, 4, 3, 2, 5]);
reverse_equals([1, 2, 3, 4, 5], [1, 3, 4, 2, 5]);
reverse_equals([1, 2, 3, 4, 5], [1, 2, 3, 4, 5]);
reverse_equals([1, 2, 3, 4, 5], [5, 4, 3, 2, 1]);
reverse_equals([3], [3]);
reverse_equals([], []);
reverse_equals([1, 2, 3, 4, 5], [4, 3, 2, 1]);

sub reverse_equals {
	
	my (@a, @b, $i, $j, $k, $jj, $result);
	
	@a = @{$_[0]};
	@b = @{$_[1]};
	
	# cannot be true if the array are different lengths
	if ($#a == $#b) {
		
		# in case strings are identical
		$result = $#a > -1 ? qq[0 to 0] : 'zero-length subarray';
		
		# find start of potential reversal
		A: for $i (0 .. $#a - 1) {
			next if $a[$i] == $b[$i];
			$result = '';
				
			# find potential end
			B: for ($j = $#b; $j >= $i; $j --) {
				next if $b[$j] == $a[$j];
				
				# check for reversibility
				$jj = $j;
				K: for $k ($i .. $j) {
					last A if $a[$k] != $b[$jj];
					last K if -- $jj < $k;
				}
				
				# success!
				$result .= qq[$i to $j];
				last A;			
			}
			last A;
		}				
	} 

	say qq[\nInput:  \@a = (] . join(', ', @a) . qq[),\n        \@b = (] . join(', ', @b) . q[)];
	say qq[Output: ] . ($result ? qq[true - $result] : 'false');
}

#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-10-20
use utf8;     # Week 344 - task 2 - Array formation
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;
use Algorithm::Combinatorics 'permutations';

array_formation([[2, 3], [1], [4]], [1, 2, 3, 4]);
array_formation([[1, 3], [2], [4]], [1, 2, 3, 4]);
array_formation([[9, 1], [5, 8], [2]], [5, 8, 2, 9, 1]);
array_formation([[1], [3]], [1, 2, 3]);
array_formation([[1], [2], [3], [4]], [1, 2, 3]);
array_formation([[3, 5], [2, 6, 5], [4, 1, 5], [3, 1], [9]], [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]);

sub array_formation {
	
	my (@source, @target, $iter, $c, @trial, $j, $explain, $source_text, $source_count);
	
	# initialise
	@source = @{$_[0]};
	@target = @{$_[1]};
	$source_text .= '[' . join(', ', @{$source[$_]}) . ']' for 0 .. $#source;
	$source_text =~ s|\Q][|], [|g for 0 .. $#source;	
	say qq{\nInput:  \@source = ($source_text)\n        \@target = (} . join(', ', @target) . ')';
	
	# must be same number of numbers in source and target
	$source_count += @{$_} for @source;
	if ($source_count == @target) {
	
		$iter = permutations(\@source);
			
		# loop over all perms of source sub-arrays
		ITER: while ($c = $iter->next) {
			@trial = ();
			$explain = '';
			
			# concatenate the sources
			for (@$c) {
				push @trial, @{$_};
				$explain .= '(' . join(', ', @{$_}) . '), ';
			}
			
			# check if the concatenated sources match the target
			for $j (0 .. $#target) {
				next ITER unless $trial[$j] == $target[$j];
			}
			
			# they do!
			say qq[Output: true -- ] . substr($explain, 0, -2);
			return;		
		}
	}
	say qq[Output: false];
}

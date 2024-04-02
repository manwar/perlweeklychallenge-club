#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-04-01
use utf8;     # Week 263 - task 1 - Target index
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my (@ints, $j);

target_index([1, 5, 3, 2, 4, 2], 2);
target_index([1, 2, 4, 3, 5], 6);
target_index([5, 3, 2, 4, 2, 1], 4);

# bigger example
for $j (0 .. 500) {
	push @ints, int(rand(30) + 1);
}
target_index(\@ints, 15);

sub target_index {
	
	my (@ints, $int, $k, $m, $n, $output);
	
	# initialise
	@ints = @{$_[0]};
	$k = $_[1];
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . qq[), \$k = $k];
		
	# count integers less than $k and equal to $k
	$n = $m = 0;
	for $int (@ints) {
		$n ++ if $int < $k;
		$m ++ if $int == $k;
	}
	
	# show results	
	$output = '';
	$output .= qq[$_, ] for $n .. ($n + $m - 1);
	say qq[Output: (] . substr($output, 0, -2) . ')';
}

#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-12-30
use utf8;     # Week 302 - task 1 - Ones and zeroes
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Algorithm::Combinatorics 'subsets';

ones_and_zeroes(['10', '0001', '111001', '1', '0'], 5, 3);
ones_and_zeroes(['10', '1', '0'], 1, 1);
ones_and_zeroes(['000000', '1111'], 5, 3);
ones_and_zeroes(['10101010101', '0000001111', '1', '0'], 5, 3);
ones_and_zeroes(['0'], 5, 3);
ones_and_zeroes(['00', '01', '10', '11', '00', '01', '10', '11', '00', '01', '10', '11'], 1, 1);

sub ones_and_zeroes {
	
	my ($s, $max0, $max1, $iter, $subset, $joined, $size, $num0, $num1, $best_size, $best_subset);
	
	# initialise
	($s, $max0, $max1) = @_;
	$iter = subsets($s);
	$best_size = 0;
	
	# loop over all subsets
	while ($subset = $iter->next) {
		
		# concatenate the strings and abandon if smaller than the best so far
		$size = @$subset;
		next if $size <= $best_size;
		
		# check the number of 1s and 0s and abandon if too many 1s or 0s
		$joined = join('', @$subset);
		$num0 = $joined =~ s|0|0|g;
		$num1 = length($joined) - $num0;
		next if ($num0 > $max0 or $num1 > $max1);
		
		# found a better one
		$best_size = $size;
		$best_subset = join(qq[', '], @$subset);		
	}
	
	# report
	say qq[\nInput:  \@str = ('] . join(q[', '], @$s) . qq['), \$x = $max0, \$y = $max1];
	say qq[Output: ] . ($best_size > 0 ? qq[('$best_subset'), size = $best_size] : 'none');
}

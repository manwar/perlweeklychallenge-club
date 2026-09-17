#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-09-14
use utf8;     # Week 391 - task 2 - Arrange box
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

arrange_box([1, 3], [3, 5], [6, 8], [2, 4]);
arrange_box([4, 5], [4, 6], [6, 7], [2, 3], [4, 3]);
arrange_box([5, 5], [5, 5], [5, 5]);
arrange_box([2, 100], [3, 200], [4, 300], [5, 50], [5, 400]);
arrange_box([10, 20], [15, 10], [20, 30], [12, 18], [16, 25]);
arrange_box([1, 3], [3, 5], [6, 8], [2, 4], [4, 5], 
	[4, 6], [6, 7], [2, 3], [4, 3], [8, 14],
	[2, 100], [3, 200], [4, 300], [5, 50], [5, 400],
	[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]);

sub arrange_box {
	
	my ($input, @boxes, $i, $j, $z, %fits, $max_length, $mask, @path, 
		$best, $length);
	
	# report input
	@boxes = @_;
	$input .= qq{[$boxes[$_]->[0], $boxes[$_]->[1]], } 
		for 0 .. scalar $#boxes;
	say qq[\nInput: (] . substr($input, 0, -2) . ')';

	# sort boxes by increasing area
	@boxes = sort { ($a->[0] * $a->[1]) <=> ($b->[0] * $b->[1]) } @_;
	
	# box i fits into box j if $fits{$i} =~ m|:$j:|
	for $i (0 .. $#boxes - 1) {
		for $j ($i + 1 .. $#boxes) {
			if ($boxes[$i]->[0] < $boxes[$j]->[0] and 
				$boxes[$i]->[1] < $boxes[$j]->[1]) {
				$fits{$i} .= ":$j:";
			}
		}
	}
	
	# loop over possible paths
	$max_length = 0;
	M: for ($mask = (2 ** scalar @boxes) - 1; $mask > 0; $mask --) {
		
		# get one path
		@path = ();
		for $i (0 .. $#boxes) {
			push @path, $i if $mask & (2 ** $i);
		}
		
		# loop over boxes in path, quitting if one won't fit in next
		for $j (1 .. $#path) {
			next M unless defined $fits{$path[$j - 1]} and 
				$fits{$path[$j - 1]} =~ m|:$path[$j]:|;
		}

		# found a good path	- but it is the best?
		$length = scalar @path;
		if ($length > $max_length) {
			$max_length = $length;
			$best = '';
			$best .= qq{[$boxes[$_]->[0], $boxes[$_]->[1]] -> } 
				for @path;
			$best = substr($best, 0, -4);
		}
	}

	# report
	say qq[Output: largest set = $max_length] . 
		($max_length > 1 ? qq[: $best] : '');
}

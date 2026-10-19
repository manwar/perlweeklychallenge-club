#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/396/1

use v5.26;    # The Weekly Challenge - 2026-10-19
use utf8;     # Week 396 - task 1 - Finishing order
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

finishing_order([3, 1, 4, 2, 5], [1, 2, 4]);  # 1 4 2
finishing_order([5, 4, 3, 2, 1], [1, 3, 5]);
finishing_order([2, 4, 1, 3], [1, 2, 3, 4]);
finishing_order([4, 1, 3, 2], [3]);
finishing_order([1, 3, 2, 6, 5, 4], [1, 2, 3]);

sub finishing_order {
	
	my (@order, @friends, @places);
	
	# initialise
	@order = @{$_[0]};
	@friends = @{$_[1]};
	say qq[\nInput:  \@order = (] . join(', ', @order) .
		qq[), \@friends = (] . join(', ', @friends) . ')';
	
	# make $places[$j] == placing of $friend[$j]
	$places[$order[$_]] = $_ + 1 for 0 .. $#order;
	
	# order friends by their placing
	@friends = sort {$places[$a] <=> $places[$b]} @friends;
	
	# report
	say qq[Output: (] . join(', ', @friends) . ')';
}

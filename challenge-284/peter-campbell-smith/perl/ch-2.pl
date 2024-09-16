#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-08-26
use utf8;     # Week 284 - task 2 - Relative sort
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

relative_sort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6]);
relative_sort([3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2]);
relative_sort([3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2]);

sub relative_sort {
	
	my (@list1, @list2, @list3, @list4, $j, $k);
	@list1 = @{$_[0]};
	@list2 = @{$_[1]};
	say qq[\nInput:  \@list1 =  (] . join(', ', @list1) . ')';
	
	# loop over @list2
	for $j (0 .. @list2 - 1) {
		for $k (0 .. @list1 - 1) {
			next unless defined $list1[$k];
			
			# move any matching items in @list1 to @list3
			if ($list2[$j] == $list1[$k]) {
				push @list3, $list1[$k];
				$list1[$k] = undef;
			}
		}
	}
	# move any non-matching items into @list4
	for $k (0 .. @list1 - 1) {
		push @list4, $list1[$k] if defined $list1[$k];
	}
	
	# concatenate @list3 and sorted @list4
	push @list3, sort {$a <=> $b} @list4;
	
	say qq[	\@list2 =  (] . join(', ', @list2) . ')';
	say qq[Output:           (] . join(', ', @list3) . ')';
}

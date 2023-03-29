#!/usr/bin/perl

use v5.16;       # The Weekly Challenge - 2023-03-27
use utf8;        # Week 210 task 1 - Kill and win
use strict;      # Peter Campbell Smith
use warnings;    # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my ($best, $max, $j, @test);

kill_and_win(2, 3, 1);
kill_and_win(1, 1, 2, 2, 2, 3);
kill_and_win(1, 3, 5, 7);
kill_and_win(2, 2, 2, 2);
kill_and_win(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

# harder one - 20 random numbers in 0 .. 15
for $j (0 .. 19) {
	@test[$j] = int(rand(15));
}
kill_and_win(@test);

sub kill_and_win {
	
	# does what the challenge says
	my (@list);
	
	@list = @_;
	$best = 0;
	$max = 0;
	
	# the max possible is the sum of all the list elements and we can stop if we find that
	$max += $_ for @list;
	
	# get the answer and show it
	kill_one(\@list);	
	say qq[\nInput:  \@list = (] . join(', ', @list) . qq[)];
	say qq[Output: $best (max = $max)];
}

sub kill_one {
	
	# finds all options of deleting one entry from list and recurses 
	my ($option, @list, $j, $k, @new_list, $score, $yes);
	@list = @{$_[0]};
	
	# if we've found a solution that scores $max we can stop
	return 0 if $best == $max;
	$score = 0;
	
	# take an element to delete (if possible)
	J: for $j (0 .. scalar @list - 1) {
		
		# is this eligible for deletion as there is at least one ± 1
		$yes = 0;
		K: for $k (0 .. scalar @list - 1) {
			if (abs($list[$j] - $list[$k]) == 1) {
				$yes = 1;
				last K;
			}
		}
		
		# not eligible
		next J unless $yes;
		
		# so we can delete $list[$j]
		$score = $list[$j];
		
		# create a new list omitting $j and any element ± 1 from element $j
		@new_list = ();
		for $k (0 .. scalar @list - 1) {
			next if $j == $k;
			if (abs($list[$j] - $list[$k]) == 1) {
				$score += $list[$k];
				next;
			}
			push(@new_list, $list[$k]);
		}
				
		# if there are still >1 elements in $new_list, recurse
		$score += kill_one(\@new_list) if scalar @new_list > 1;

		# save the score if it's the best so far
		$best = $score if $score > $best;
	}
	return $score;
}

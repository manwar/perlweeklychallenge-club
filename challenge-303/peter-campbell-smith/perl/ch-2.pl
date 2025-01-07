#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-01-06
use utf8;     # Week 303 - task 2 - Delete and earn
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my ($max_earnings, $max_explain);

delete_and_earn(2, 2, 3, 3, 3, 4);
delete_and_earn(2, 2, 3, 3, 4, 4);
delete_and_earn(1, 3, 5, 7, 9);
delete_and_earn(1, 2, 3, 4, 5);

sub delete_and_earn {
	
	my (@ints, @amounts, @new_amounts, $j);
	
	# initialise
	@ints = @_;
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	
	# set up $amounts[$j] = no of $j's in @ints
	$amounts[$_] ++ for @ints;
	for $j (0 .. $#amounts) {
		$amounts[$j] = 0 unless defined $amounts[$j];
	}
	$max_earnings = 0;
	
	# call d_and_e
	d_and_e(\@amounts, 0, '');
	say qq[Output: $max_earnings (] . substr($max_explain, 3) . ')';
}

sub d_and_e {
	
	my (@amounts, @new_amounts, $more, $earnings, $new_earnings, $j, $explain, $new_explain);
	
	# descend one level
	@amounts = @{$_[0]};
	$earnings = $_[1];
	$explain = $_[2];
	
	# find each uncashed number
	for $j (0 .. $#amounts) {
		next unless $amounts[$j] > 0;
		
		# cash it
		$new_earnings = $earnings + $j;
		$new_explain = qq[$explain + $j];
		if ($new_earnings > $max_earnings) {
			$max_earnings = $new_earnings;
			$max_explain = $new_explain;
		}
		
		# update amounts for recursive call
		@new_amounts = @amounts;
		$new_amounts[$j] --;
		$new_amounts[$j - 1] = 0 if $j > 0;
		$new_amounts[$j + 1] = 0 if $j < $#amounts;
		d_and_e(\@new_amounts, $new_earnings, $new_explain);
	}
}

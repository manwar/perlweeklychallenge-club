#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-05-29
use utf8;     # Week 219 task 2 - Travel expenditure
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my (@costs, @periods, @days, $best_cost, $best_explain);

travel_exps([2, 7, 25], [1, 7, 30], [1, 5, 6, 7, 9, 15]);
travel_exps([2, 7, 25], [1, 7, 30], [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]);
travel_exps([2, 7, 13], [1, 7, 14], [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]);

# generate longer example
my ($j, @daysx);
for $j (1 .. 100) {
	push @daysx, $j if rand(1) < 0.4;
}
travel_exps([2, 7, 13], [1, 7, 14], \@daysx);


sub travel_exps {
	
	# initialise
	@costs = @{$_[0]};
	@periods = @{$_[1]};
	@days = @{$_[2]};
	$best_explain = '';
	$best_cost = 99999;
	
	# start recurive solution
	buy_tickets(\@days, 0, '');
	
	# show results
	say qq[\nInput:  \@costs   = (] . join(', ', @costs) . ')';
	say qq[        \@periods = (] . join (', ', @periods) . ')';
	say qq[        \@days    = (] . join (', ', @days) . ')';
	say qq[Output: $best_cost = ] . substr($best_explain, 0, -2);
}

sub buy_tickets {
	
	my (@days_left, $cost, $purchase_day, $j, $valid_until, $explain, $explain2, $cost2, @days_left2);
	
	# initialise
	@days_left = @{$_[0]};
	$cost = $_[1];
	$explain = $_[2];
				
	# try buying each type of ticket and see which days it covers
	for ($j = 2; $j >= 0; $j --) {
		$cost2 = $cost + $costs[$j];
		@days_left2 = @days_left;
		$purchase_day = $days_left2[0];
		$explain2 = qq[$explain$periods[$j] day ticket on day $purchase_day, ];
		$valid_until = $purchase_day + $periods[$j] - 1;
		
		# remove days now paid for
		while (@days_left2 and $days_left2[0] <= $valid_until) {
			shift @days_left2;
		}
		
		# have we finished?
		if (scalar @days_left2 == 0) {
			
			# is this the best deal
			if ($cost2 < $best_cost) {
				$best_cost = $cost2;
				$best_explain = $explain2;
			}

		# buy more tickets to cover remaining days
		} elsif ($cost2 < $best_cost) {
			buy_tickets(\@days_left2, $cost2, $explain2);
		}
	}
}

			
			
	
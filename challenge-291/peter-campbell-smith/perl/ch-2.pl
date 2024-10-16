#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-10-14
use utf8;     # Week 291 - task 2 - Poker hand rankings
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Algorithm::Combinatorics qw(combinations);


# need to have ace-high and low ###

poker_hand_rankings();

sub poker_hand_rankings {
	
	my ($i, $c, @data, $count, $card, @hand, $value, $suit, @suits, @m, @rank, @counts, $j, $combs, $secs, $start,
		$k, @ranks);
	
	say qq[\n1. How many different 5-card hands can be dealt?];
	say qq[Answer: 52! / (47! × 5!) = ] . (52 * 51 * 50 * 49 * 48 / (5 * 4 * 3 * 2));
	say '';
	
	# initialise
	@data = reverse(0 .. 51);
	$i = combinations(\@data, 5);
	$count = 0;
	@rank[$_] = 0 for 0 .. 10;
	$start = time();
	
	# loop over all possible combinations
	COMB: while ($c = $i->next) {
		
		# analyse combination
		$count ++;
		say qq[tested ] . ($count / 1000) . qq[k hands in ] . (time() - $start) . qq[ sec] if ($count % 100000 == 0);
		@hand = ();

		# split card number (0 .. 51) into suit (0 .. 3) and rank (0 .. 12)
		for $card (@$c) {
			$suit = int($card / 13);
			$value = $card % 13;
			push @hand, $suit, $value;
		}
		
		# straight flush (5 consecutive in same suit)
		if ($hand[2] == $hand[0] and $hand[4] == $hand[0] and $hand[6] == $hand[0] and $hand[8] == $hand[0]) {
			if ($hand[1] >= 4
				and $hand[3] == $hand[1] - 1 and $hand[5] == $hand[1] - 2 and $hand[7] == $hand[1] - 3 and $hand[9] == $hand[1] - 4) {
				$rank[2] ++;
				next COMB;
			}	
			if ($hand[9] == 0  # check for ace high
				and $hand[1] == 12 and $hand[3] == 11 and $hand[5] == 10 and $hand[7] == 9) {							
				$rank[2] ++;				
				next COMB;
			}
		}
			
		# four of a kind (4 of same rank)
		@counts[$_] = 0 for 0 .. 12;
		for $j (0 .. 4) {
			$counts[$hand[2 * $j + 1]] ++;
		}
		$k = 0;
		for $j (0 .. 12) {
			if ($counts[$j] == 4) {
				$rank[3] ++;
				next COMB;
			}
		
			# full house (3 of one rank + 2 of another)
			$k |= 1 if $counts[$j] == 3;
			$k |= 2 if $counts[$j] == 2;
			if ($k == 3) {	
				$rank[4] ++;
				next COMB;
			}
		}
		
		# flush (5 of same suit)
		@counts[$_] = 0 for 0 .. 3;		
		for $j (0 .. 4) {
			$counts[$hand[2 * $j]] ++;
		}
		for $j (0 .. 3) {
			if ($counts[$j] == 5) {
				$rank[5] ++;
				next COMB;
			}
		}
		
		# straight (5 with sequential ranks)
		@ranks = sort { $a <=> $b }($hand[1], $hand[3], $hand[5], $hand[7], $hand[9]);			
		if ($ranks[4] >= 4
			and $ranks[3] == $ranks[4] - 1 and $ranks[2] == $ranks[3] - 1 
			and $ranks[1] == $ranks[2] - 1 and $ranks[0] == $ranks[1] - 1) {
			$rank[6] ++;
			next COMB;
		}
		if ($ranks[0] == 0   # check for ace high
			and $ranks[1] == 9 and $ranks[2] == 10 and $ranks[3] == 11 and $ranks[4] == 12) {
			$rank[6] ++;
			next COMB;
		}				

		
		# three of a kind (3 of same rank)
		@counts[$_] = 0 for 0 .. 12;
		for $j (0 .. 4) {
			$counts[$hand[2 * $j + 1]] ++;
		}
		$k = 0;
		for $j (0 .. 12) {
			if ($counts[$j] == 3) {
				$rank[7] ++;
				next COMB;
			}		
		}
		
		# two pair (2 of one rank, 2 of another, 1 of yet another)
		@counts[$_] = 0 for 0 .. 12;
		for $j (0 .. 4) {
			$counts[$hand[2 * $j + 1]] ++;
		}
		$k = 0;
		for $j (0 .. 12) {
			$k ++ if $counts[$j] == 2;
			if ($k == 2) {	
				$rank[8] ++;
				next COMB;
			}
		}
		
		# one pair (2 of one rank)
		@counts[$_] = 0 for 0 .. 12;
		for $j (0 .. 4) {
			$counts[$hand[2 * $j + 1]] ++
		}
		$k = 0;
		for $j (0 .. 12) {
			$k ++ if $counts[$j] == 2;
			if ($k == 1) {	
				$rank[9] ++;
				next COMB;
			}
		}
		
		# high card (anything else)
		$rank[10] ++;
	}
	
	# results
	say qq[\n2. How many different hands of each of the 10 ranks can be dealt?\n];
	say qq[Five of a kind:  ] . sprintf('%7d', $rank[1]);
	say qq[Straight flush:  ] . sprintf('%7d', $rank[2]);
	say qq[Four of a kind:  ] . sprintf('%7d', $rank[3]);
	say qq[Full house:      ] . sprintf('%7d', $rank[4]);
	say qq[Flush:           ] . sprintf('%7d', $rank[5]);
	say qq[Straight:        ] . sprintf('%7d', $rank[6]);
	say qq[Three of a kind: ] . sprintf('%7d', $rank[7]);
	say qq[Two pair:        ] . sprintf('%7d', $rank[8]);
	say qq[One pair:        ] . sprintf('%7d', $rank[9]);
	say qq[High card:       ] . sprintf('%7d', $rank[10]);
	
	say qq[\n3. Total:        $count - matches answer 1 above.\n];
	
}

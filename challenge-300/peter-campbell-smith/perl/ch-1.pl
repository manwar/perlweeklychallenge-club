#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-12-16
use utf8;     # Week 300 - task 1 - Beautiful arrangement
use warnings; # Peter Campbell Smith
use Algorithm::Combinatorics 'permutations';
binmode STDOUT, ':utf8';

for (2 .. 11) {
	beautiful_arrangement1($_);
	beautiful_arrangement2($_);
}

sub beautiful_arrangement1 {
	
	my ($n, @array, $iter, $next, $i, $start, @order, @possible, $beautiful);
	
	# initialise
	$n = shift;
	$beautiful = 0;
	$start = time();
	push(@array, $_) for 1 .. $n;
	
	# loop over perms
	$iter = permutations(\@array);
	PERM: while ($next = $iter->next) {
		for $i (1 .. $n) {
			
			# test for ugliness
			unless ($i == $next->[$i - 1]) {
				next PERM unless $i > $next->[$i - 1] 
					? $i % $next->[$i - 1] == 0 
					: $next->[$i - 1] % $i == 0;
			}
		}
		
		# not ugly
		$beautiful ++;
	}
	say qq[\nInput:  \$n = $n];
	say qq[Output1: $beautiful (] . (time() - $start) . qq[ secs)];
}

sub beautiful_arrangement2 {
	
	my ($i, $j, $k, $start, @count, $n, $iter, $next, $m, $beautiful, @possible,
		@order, @array);
	
	# initialise
	$n = shift;
	$beautiful = 0;
	$start = time();
	
	# find possible values of each $array[$i]
	for $i (1 .. $n) {	
		$possible[$i] = '~';
		for $j (1 .. 999) {
			
			# multiples
			if ($i * $j <= $n) {
				$possible[$i] .= $i * $j . '~';
			}
			
			# divisors
			if ($j > 1 and $i / $j >= 1 and $i % $j == 0) {
				$possible[$i] .= $i / $j . '~';
			}
		}
	}
	
	# $count[$i] is the no of possible values at $array[$i]
	for $i (1 .. $n) {
		$count[$i] = ($possible[$i] =~ s|~|~|g) - 1;
	}
	
	# @order is the hardest to easiest order to fill
	for $i (1 .. $n) {
		for $j (1 .. $n) {
			if ($count[$j] == $i) {
				push @order, $j;
			}
		}
	}
	
	# now start	as before
	push(@array, $_) for 1 .. $n;
	
	# loop over perms
	$iter = permutations(\@array);
	PERM: while ($next = $iter->next) {
		for $k (0 .. $n - 1) {
			
			# test for ugliness in order of probability
			$i = $order[$k];
			$m = $next->[$i - 1];
			unless ($i == 1 or $i == $m) {
				next PERM unless $i > $m ? $i % $m == 0 : $m % $i == 0;
			}
		}
		
		# not ugly
		$beautiful ++;
	}
	
	say qq[Output2: $beautiful (] . (time() - $start) . qq[ secs)];
}

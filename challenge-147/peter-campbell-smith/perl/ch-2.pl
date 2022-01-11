#!/usr/bin/perl

# Peter Campbell Smith - 2022-01-10
# PWC 147 task 2

use v5.28;
use warnings;
use strict;

# Write a script to find the first pair of Pentagon Numbers whose sum and difference 
# are also a Pentagon Number. Pentagon numbers can be defined as P(n) = n(3n - 1)/2.

my $seeking = 1;
# first_method();   # see blog - it works but is slow
second_method();    # this is better

#---

sub first_method {

	# first method 
	my ($found, $n, $pentagon, %p, @f, $m, $diff, %queue, $sum, $mm, $nn, $sum2, $start);

	$start = time;
	$found = 0;

	for ($n = 1; ; $n ++) {
		
		# generate pentagon numbers sequentially
		$pentagon = $n * (3 * $n - 1) / 2;
		$p{$pentagon} = $n;     # so for any $j <= $n, $j is a pentagon number if $p{$j}
		$f[$n] = $pentagon;     # and the $jth pentagon number is $f[$j]
		next if $n == 1;
		
		# check the difference between this pentagon number ($n) and all smaller ones ($m)
		for $m (1 .. $n - 1)	{
			$diff = $pentagon - $f[$m];
			next unless $p{$diff};   # difference is not a pentagon number
			
			# the difference is pentagonal; the sum will be more than $pentagon so put it in a queue to be checked later
			$queue{sprintf('%012d', $f[$m] + $pentagon)} = [$m, $n];   # zero padded key so they sort numerically
			
			# test per wikipedia
			$sum = $f[$m] + $pentagon;
		}
		
		# is $pentagon in the queue of possible answers?
		for $sum (sort keys %queue) {
			($mm, $nn) = @{$queue{$sum}};
			
			# this queued number is the sum of 2 pentagons which differ by a pentagon, so ... an answer!
			if ($sum == $pentagon) {   # the queued sum is the pentagon we've just found
				$diff = $f[$nn] - $f[$mm];
				$sum2 = $sum + 0;   # get rid of zero padding
				say qq[First method: ];
				say qq[Pentagon no $mm is $f[$mm]];
				say qq[Pentagon no $nn is $f[$nn]];
				say qq[Their sum is $sum2 which is pentagon number $n];
				say qq[Their difference is $diff which is pentagon number $p{$diff}];
				
				if (++ $found == $seeking) {  # we've achieved the goal
					say '' . (time - $start) . qq[ seconds\n];
					return;
				}
				delete $queue{$sum};
				
			# this queued sum of 2 pentagon numbers is less than the one we just found, 
			# so it isn't a pentagon number, so take it out of the queue
			} elsif ($sum < $pentagon) {
				delete $queue{$sum};
				
			# else it's still larger than the pentagon we just found, so leave it in the queue	
			} else {
				last;   # and any others are larger still so we con;t need to look at them yet
			}
		}
	}
}

sub second_method {
	
	my ($found, $n, $i, $s, $m, $diff, $sum, %p, @f, $start);
	
	$found = 0;
	$start = time;

	for ($n = 1; ; $n ++) {
		
		# find pentagon numbers sequentially 
		next unless ($i = is_pentagonal($n));   # so $n is the $i'th pentagon

		# so $n is pentagonal
		$f[$i] = $n;        # and the $i'th pentagon number is $f[$i]
		$p{$n} = $i;        # if n is a pentagon, it is the $p{$n}'th one
		next if $n == 1;
		
		# check the difference and sum of this pentagon number ($n) and all smaller ones ($m)
		for $m (1 .. $i - 1)	{
			$diff = $n - $f[$m]; 
			$sum = $n + $f[$m];
			
			# difference is not a pentagon number
			next unless $p{$diff};
			next unless $s = is_pentagonal($sum);   # sum is not a pentagon number
			
			# result!
			say qq[Second method: ];
			say qq[Pentagon no $i is $n];
			say qq[Pentagon no $m is $f[$m]];
			say qq[Their sum is $sum which is pentagon number $s];			
			say qq[Their difference is $diff which is pentagon number $p{$diff}];
			if (++ $found == $seeking) {
				say '' . (time - $start) . qq[ secs\n];
				return;
			}
		}
	}
}

sub is_pentagonal {
	
	# per Wikipedia
	
	my $test = (sqrt(24 * $_[0] + 1) + 1) / 6;
	my $test1 = $test - int($test + 1e-19);
	return (abs($test1) <= 1e-19) ? $test : 0;
}


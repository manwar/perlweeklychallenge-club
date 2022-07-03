### https://theweeklychallenge.org/blog/perl-weekly-challenge-171/
#
### Task 1: Abundant Number
### Submitted by: Mohammad S Anwar
### Write a script to generate first 20 Abundant Odd Numbers.
### 
### According to wikipedia,
### 
### 
### A number n for which the sum of divisors σ(n) > 2n, or, equivalently, the sum of proper divisors (or aliquot sum) s(n) > n.
### 
### 
### For example, 945 is the first Abundant Odd Number.
### 
### Sum of divisors:
### 1 + 3 + 5 + 7 + 9 + 15 + 21 + 27 + 35 + 45 + 63 + 105 + 135 + 189 + 315 = 975
#
use strict;
use warnings;

sub isAbundant{
	### default potential divisor starts with 2 and increases by 1, sum default to 1 as 1 is always a proper divisor
	my($n, $d, $step, $sum) = (shift, 2, 1, 1);
	return 0 unless $n > 1;
	### if the number is odd, a potential divisor starts with 3 and increases by 2 as it has to be odd
	($d, $step) = (3, 2) if $n % 2;
	my $lim = sqrt $n;
	{
		last if $d > $lim;
		unless ($n % $d){
			$sum += $d;
			unless ($n == $d * $d){
				$sum += $n/$d;
			}
			return 1 if $sum > $n;
		}
		$d += $step;
		redo;
	}
	return 0;
}

### check and print if an odd number is abundant, start from 1 and exit when certain numbers of them are found
my($cntdwn, $n, $step) = (20, 1, 2);
{
	printf("%s%s", $n, --$cntdwn ? ", " : "\n") if isAbundant($n);
	last unless $cntdwn;
	$n += $step;
	redo;
}

#!/usr/bin/perl

use v5.26;    # The Weekly Challenge - 2023-11-27
use utf8;     # Week 245 task 2 - Largest of three
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use Algorithm::Combinatorics 'combinations';

my ($j, @digits);

largest_of_three(8, 6, 7, 1, 0);
largest_of_three(0);
largest_of_three(18446744073709551614, 3);
largest_of_three(333, 666, 1, 4, 7);

# for $j (0..9) {
	# push @digits, int(rand(10000));
# }
# largest_of_three(@digits);
largest_of_three(13, 14, 1, 102);

sub largest_of_three {
	
	my (@digits, $c, $iter, $comb, @set, $value, $result, $length);
	
	# loop over sizes of combination to consider
	@digits = @_;
	$result = -1;
	$length = 0;
	
	for ($c = @digits; $c > 0; $c --) {
		
		# iterate over combinations of length $c numbers
		$iter = combinations(\@digits, $c);
		while ($comb = $iter->next) {
			
			# reverse sort them alphabetically to get best bet first
			@set = reverse sort @$comb;
			
			# concatenate them and see if that's the best so far
			$value = join('', @set);
			
			# this if is just: if (mult_of_3($value) and $value > $result) accommodating BigInts
			if (is_mult_of_3($value) and (length($value) > $length
					or (length($value) eq $length and $value gt $result))) {
				$result = $value;
				$length = length($result);
			}
		}
		
		# if we have an answer, no smaller subset will produce a larger number
		last if $result >= 0;
	}
	
	say qq[\nInput:  \@digits = (] . join(q[, ], @_) . q[)];
	say qq[Output: $result];
}

sub is_mult_of_3 {
	
	my ($input, $sum);
	
	$input = shift;
	$sum = 0;
	$sum += $1 while $input =~ m|(\d)|g;
	return $sum % 3 == 0;
	
}

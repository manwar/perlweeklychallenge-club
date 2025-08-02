#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-01-06
use utf8;     # Week 303 - task 1 - 3-digits even
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

three_digits_even(2, 2, 8, 8, 2);
three_digits_even(12, 7, 99, 9);
three_digits_even(22, 44, 66);
three_digits_even(122, 244, 366);
three_digits_even(1, 2, 3, 4, 5);
three_digits_even(1, 12, 124, 1234, 4, 2);

# longer example
my @ints;
push @ints, int(rand(100)) for 0 .. 30;
three_digits_even(@ints);

sub three_digits_even {
	
	my (@ints, $j, $int, %results, @even_ones, @even_twos, @odd_ones, @odd_twos,
		@all_ones, $a, $b, $k, $l);
	
	@ints = @_;
	
	# first pass through
	for $j (0 .. $#ints) {
		$int = $ints[$j];
		
		# anything longer than 3 digits can be discarded
		next if length($int) > 3;
		
		# anything 3 digits long and even can be added to results
		if (length($int) == 3) {
			$results{$int} = 1 if ($int & 1) == 0;
			next;
		}
		
		# now make lists of twos and ones
		if ($int =~ m|^[24680]$|) {
			push @even_ones, $int;
		} elsif ($int =~ m|^[13579]$|) {
			push @odd_ones, $int;
		} elsif ($int =~ m|[24680]$|) {
			push @even_twos, $int;
		} else {
			push @odd_twos, $int;
		}
	}
		
	# valid results are any one followed by an even two
	for $a (@even_ones, @odd_ones) {
		for $b (@even_twos) {
			$results{"$a$b"} = 1;
		}
	}
	
	# or any two followed by an even one
	for $a (@even_twos, @odd_twos) {
		for $b (@even_ones) {
			$results{"$a$b"} = 1;
		}
	}
	
	# or any two ones followed by an even one
	@all_ones = (@even_ones, @odd_ones);
	for $j (0 .. scalar @all_ones - 1) {
		for $k (0 .. scalar @all_ones - 1) {
			next if $j == $k;
			for $l (0 ... scalar @all_ones - 1) {
				next if $l == $j or $l == $k or ($all_ones[$l] & 1);
				$results{"$all_ones[$j]$all_ones[$k]$all_ones[$l]"} = 1;
			}
		}
	}

	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	say qq[Output: (] . join(', ', sort keys %results) . ')';
}

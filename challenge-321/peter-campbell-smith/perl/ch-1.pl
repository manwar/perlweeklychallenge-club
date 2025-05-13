#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-05-12
use utf8;     # Week 321 - task 1 - Distinct average
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

distinct_average(1, 2, 4, 3, 5, 6);
distinct_average(0, 2, 4, 8, 3, 5);
distinct_average(7, 3, 1, 0, 5, 9);

# larger example
my @numbers;
push @numbers, int(rand(100)) for 0 .. 99;
distinct_average(@numbers);

sub distinct_average {
	
	my (@numbers, $j, %sums, $count);
	
	@numbers = @_;
	say qq[\nInput:  (] . join(', ', @numbers) . q[)];
	
	# sort numbers and sum them pairwise from each end
	@numbers = sort {$a <=> $b}  @numbers;
	$sums{$numbers[$_] + $numbers[$#numbers - $_]} = 1 for 0 .. @numbers / 2;
	
	# count the number of unique sums
	$count ++ for keys %sums;
	
	say qq[Output: $count];
}

#!/usr/bin/perl

# Peter Campbell Smith : 2021-08-02

use strict;
use utf8;
use warnings;

use Algorithm::Combinatorics qw(combinations);

# Required: You are given a set of $n integers (n1, n2, n3, ….).

# Write a script to divide the set in two subsets of n/2 sizes each so that the difference 
# of the sum of two subsets is the least. If $n is even then each subset must be of size $n/2
# each. In case $n is odd then one subset must be ($n-1)/2 and other must be ($n+1)/2.

# Method:
# The aim is to find a subset of $n/2 (or ($n-1)/2) of the input numbers which sums as close as
# possible to half the sum of the input set (the 'target'). The remaining subset will then sum to 
# a value the same distance from the other side of the target.

my (@in, @out1, @out2, $target, $count, $subcount, $best, $set, $c, $total, $gap, $i, $string);

# input set - uncomment one of these
# @in = (10, 20, 30, 40, 50, 60, 70, 80, 90, 100);   # example 1 given in challenge
# @in = (10, -15, 20, 30, -25, 0, 5, 40, -5);
# @in = (18, 25, 7, 39, 11, 17, 22, 1 ,41, 19, -5);
@in = (23, 67, 43, 96, 23, 14, 85, -300, 43, 20, 87, 99, 0, 35, 21, 77, 88, 77, 54, 70, 34, 56, 500);

# some useful numbers
$target = total(@in) / 2;   	# target value for each subset to add up to (half the total of the input numbers)
$count = scalar @in;        	# number of numbers
$subcount = int($count / 2);  	# number in each (or the smaller) subset

# look for subset that is closest to the target
$best = 1e10;   	# the closest gap found so far between the chosen combination and the target.

# iterate over all possible combinations of the first $subcount numbers
$set = combinations(\@in, $subcount);   
while ($c = $set->next) {
    $total = total(@$c);           # total of this combination
	$gap = int($total - $target);  # gap between that and the target
	if (abs($gap) < $best) {       # is it the best so far?
		@out1 = @$c;
		$best = abs($gap);
		print qq[best so far $best\n];
		last if $best == 0;
	}
}

# get the other subset
$string = '!' . join('!', @in) . '!';   # make the imput set into a string like !11!22!33!
for $i (@out1) {
	$string =~ s/!$i!/!/;   # remove each one which is in the fist subset
}
@out2 = split /!/, substr($string, 1);   # split the string back into an array

# print the results
print qq[
Input:        Set = (] . join(', ', @in) . qq[) sum ] . total(@in) . qq[
Output:  Subset 1 = (] . join(', ', @out1) . qq[) sum ] . total(@out1) . qq[
         Subset 2 = (] . join(', ', @out2) . qq[) sum ] . total(@out2) . qq[
];

sub total {    # total(@x) returns sum of all the elements
	
	my ($i, $sum);
	for $i (@_) { $sum += $i; }
	return $sum;

}

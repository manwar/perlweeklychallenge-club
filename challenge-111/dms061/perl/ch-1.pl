use strict;
use warnings;

# Question 1: You are given 5x5 matrix filled with integers such that
# each row is sorted from left to right and the first integer of each row
# is greater than the last integer of the previous row
# Write a script to find a given integer in the matrix using an efficient search algorithm

# Solution: 2d binary search. Elements are sorted, so binary search is a good algorithm to use
# 1st search for the array the element is in -- our "equality" check is an in range check X0 <= X <= Xn
# 2nd seach is standard binary search on the array the element is in

sub binary_search {
	# need integer division for index calcs
	# this says to use int div lexically (SCOPED)
	use integer;
	# 2 args, 1 scalar and an array
	# however, perl puts them all into 1 array, @_
	# so we shift the value param off
	# and treat @_ as the array
	#my $val = shift;
	# TODO add optimization?
	# Change this to be a helper that assumes
	# we are working on an array w/ elts (del 1st line after comments)
	# and that $val is in it
	# Add a top level binary_search that checks if
	# @arr has elements and $val is in @arr
	# this would be done so those checks occur only once
	my ($val, @arr) = @_;
	return 0 if @arr == 0;
	if(@arr == 1){
		return 1 if $arr[0] == $val;
		return 0; 
	}
	my $mid = $#arr/2;
	# Can I replace the equality / comparison ops with custom operators or functions?
	# This way, we can implement 2d_binary_search by using the regular binary search
	# and a custom comparator.
	return binary_search ($val, @arr[0..$mid-1]) if $val < $arr[$mid];
	return binary_search ($val, @arr[$mid+1..$#arr]) if $val > $arr[$mid];
	# $val == $_[$mid]
	return 1;
}

sub binary_search_2d {
	use integer;
	# 2 args, val to search for and array of refs
	my ($val, @arrs) = @_;

	# no empty array? Value can't be present
	return 0 if @arrs == 0;

	#find the middle array (will work if there is only 1 array present)	
	my $mid = $#arrs/2;
	#extract the array for easier usage
	my @mid_arr = @{$arrs[$mid]};
	# no elts in middle array, ret 0
	return 0 if @mid_arr == 0;
	# check if $val is out of range, we can't binary search if it isn't there
	if($val < $mid_arr[0]){
		return binary_search_2d($val, @arrs[0..$mid-1]);
	}elsif($val > $mid_arr[$#mid_arr]){
		return binary_search_2d($val, @arrs[$mid+1..$#arrs]);
	}
	# $val may be in array, so we can search for it now
	return binary_search $val, @mid_arr;
}

my @matrix = ( 
	[1, 2, 3, 4, 5],
	[6, 7, 8, 9, 10],
	[11, 12, 13, 14, 15],
	[16, 17, 18, 19, 20], 
	[21, 22, 23, 24, 25]);

# print out the matrix
foreach my $ref (@matrix){
	print "[@$ref]\n";
}

# Get a number to search for
print "Enter a number to search for: ";
my $val = <STDIN>;
chomp $val; #remove trailing whitespace 

if (binary_search_2d $val, @matrix){
	print "$val is in the matrix\n";	
}else{
	print "$val is not in the matrix\n";
}

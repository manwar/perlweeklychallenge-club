#!/usr/bin/env perl
#
#You are given a list of integers.
#Write a script to find the index of the first biggest number in the list.
# Example
#
#  Input: @n = (5, 2, 9, 1, 7, 6)
#  Output: 2 (as 3rd element in the list is the biggest number)
#
#  Input: @n = (4, 2, 3, 1, 5, 0)
#  Output: 4 (as 5th element in the list is the biggest number)

use strict;
use warnings;

my @n1 = (5, 2, 9, 1, 8, 6, 7, 4);
my @n2 = (4, 2, 3, 1, 5, 6, 8, 7);

sub largest{
	
	my $array = $_[0];
	my $large = $array->[0];
	my $i=0;
	my $j=0;

	foreach ( @$array )
	{		
		if ($large < $_)
		{
			$large = $_;
			$j = $i;			
		}
		$i++;
	}
	return $j;
}

print("Largest value in \@n1 is at position: " . largest (\@n1) . "\n");
print("Largest value in \@n2 is at position: " . largest (\@n2) . "\n");

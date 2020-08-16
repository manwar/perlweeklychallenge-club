use strict;
use warnings;

my @A = (7, 8, 3, 12, 10);

my @small;
foreach (0..$#A) # Traverse the array
{
my $small;
	if($_>0) #check if the index value greater than zero,if no left index value put minimum as zero
	{	
		foreach(0..$_-1) # traverse the left index elements 
		{
			$small = $A[$_] if(!defined $small || $A[$_] < $small); #find minimum of left element
		}
		$small =0 if($A[$_] < $small); #minimum as zero if no left value smaller
		push (@small, $small);
	}
	else
	{
		$small = 0; #no left value for index is zero
		push (@small, $small);
	}
	
}
print "@small";
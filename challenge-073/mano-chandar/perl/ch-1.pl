use strict;
use warnings;

my @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) ; #given array
my $S = 3; #sliding window size
my @min;
while(@A>=$S) #process the array upto slidiing window size match
{ 
	my $min;
	foreach(0..$S-1)  #traverse upto size of sliding window
	{ 
		$min = $A[$_] if(!defined $min || $A[$_] < $min); #find minimum value in array
	}
	push(@min, $min); #push the minum value from siliding window array
	shift @A; 
}
print "@min";
#!/usr/bin/perl
use warnings;
use strict;

# Write a script to print all possible series of 3 positive numbers, where in each series at least 
# one of the number is even and sum of the three numbers is always 12. For example, 3,4,5.

# We can imagine that 10 is the maximum because 10+1+1 = 12
foreach my $x (1..10) {
	foreach my $y (1..10) {
		foreach my $z (1..10) {
			my $sum = $x + $y + $z;
			printf ("%2d,%2d,%2d\n", $x, $y, $z) if ($sum == 12) and ($x % 2 == 0 or $y % 2 == 0 or $z % 2 == 0);
		}
	}
}
			

__END__

./ch-2.pl
 1, 1,10
 1, 2, 9
 1, 3, 8
 1, 4, 7
 1, 5, 6
 1, 6, 5
 1, 7, 4
 1, 8, 3
 1, 9, 2
 1,10, 1
 2, 1, 9
 2, 2, 8
 2, 3, 7
 2, 4, 6
 2, 5, 5
 2, 6, 4
 2, 7, 3
 2, 8, 2
 2, 9, 1
 3, 1, 8
 3, 2, 7
 3, 3, 6
 3, 4, 5
 3, 5, 4
 3, 6, 3
 3, 7, 2
 3, 8, 1
 4, 1, 7
 4, 2, 6
 4, 3, 5
 4, 4, 4
 4, 5, 3
 4, 6, 2
 4, 7, 1
 5, 1, 6
 5, 2, 5
 5, 3, 4
 5, 4, 3
 5, 5, 2
 5, 6, 1
 6, 1, 5
 6, 2, 4
 6, 3, 3
 6, 4, 2
 6, 5, 1
 7, 1, 4
 7, 2, 3
 7, 3, 2
 7, 4, 1
 8, 1, 3
 8, 2, 2
 8, 3, 1
 9, 1, 2
 9, 2, 1
10, 1, 1


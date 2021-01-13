use strict;
use warnings;

#Gapful Number
#Write a script to print first 20 Gapful Numbers greater than or equal to 100. Please check out the page for more information about Gapful Numbers.

my $max = 20;
my $counter = 0;
my @divided;
my @solution;

for (my $number = 100; $counter < $max; $number++) {
	my $newNumber;
	@divided = split(/d?/, $number);
	$newNumber = @divided[0].@divided[@divided-1];
	if (($number % $newNumber) == 0) {
		push(@solution, $number);
		$counter++;
	}
}
print "The first $max Gapful Numbers are:\n";

for (my $i = 0; $i < @solution; $i++) {
	print "@solution[$i]\n";
}
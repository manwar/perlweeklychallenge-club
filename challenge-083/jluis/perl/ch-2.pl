#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;
$_ = join q(),@ARGV;
if ( (@ARGV < 2) or ! /^[\d.]+$/ ) {
	say "You need to provide at least two positive numbers";
	exit
}
# we sort the imput in descending order to check first inverting 
# the biggest vaues

my @A = sort {$b <=> $a} @ARGV;


sub sum {
	my $result = 0;
	$result += $_ for @_;
	return $result;
}

my @flipped; # Values shifted so far
my $value;   # minimun of current iteratinon
my $key;     # Index of the value that gives the minimun so far

#we don't need to change the sign to more than half of the list
# the worst case are multiple equal values 
while ( $#flipped <= scalar(@A)/2) { 	

	#find the next element 
	for my $index (0..$#A) {
		#skip values shifted on previus iterations
    		next if grep {$index == $_} @flipped;

    		my @B = @A;
    		$B[$index] = -$B[$index];
    		my $sum =  sum @B;
		
    		next if $sum < 0; #only check positive sums

    		next if defined $value and $sum >= $value; #skip it is not a minimun 
    		$key = $index;
    		$value = $sum;
    		last if $sum == 0; #we have found the solution
	}
	
	last unless defined $key; #we are not goin to get better solutions
	                          #and we go to report the one we found so far
	
	push @flipped,$key;       # Record the current shifted index
	$A[$key] = -$A[$key];     # Update @A to the current solution
	undef $key;               # and prepare for the next search

	last unless $value;       # The current soution is optimal the sum of @A 
	                          # is 0 so we end
}
say scalar @flipped;

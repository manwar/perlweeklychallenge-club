#!/usr/bin/perl

use warnings;
use strict;
use feature qw( say );

# Challenge:
# Make it $200
# You have only $1 left at the start of the week. You have been given an opportunity to make it $200. The rule is simple 
# with every move you can either double what you have or add another $1. Write a script to help you get $200 with the 
# smallest number of moves.

# Solution: work backwards from goal of 200, because in theory, taking the biggest steps later (doubling, ie dividing 
# by 2 if backwards) is the fastest route.

my @solution;
my $goal = 200;
push @solution, $goal;
while ($goal > 1) {
	$goal = ($goal % 2) ? $goal-1 : $goal/2; # if odd number deduct 1 making it even, otherwise divide by 2
	push @solution, $goal;                   # push this step into the solution set
}
say join(',',reverse(@solution));

__END__

./ch-2.pl 
1,2,3,6,12,24,25,50,100,200

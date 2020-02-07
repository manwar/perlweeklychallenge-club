#!/usr/env/perl

# TASK #2 Is the room open?
# There are 500 rooms in a hotel with 500 employees having keys to all
# the rooms. The first employee opened main entrance door of all the
# rooms. The second employee then closed the doors of room numbers
# 2,4,6,8,10 and so on to 500. The third employee then closed the door
# if it was opened or opened the door if it was closed of rooms
# 3,6,9,12,15 and so on to 500. Similarly the fourth employee did the
# same as the third but only room numbers 4,8,12,16 and so on to 500.
# This goes on until all employees has had a turn.
# Write a script to find out all the rooms still open at the end.

# An array holds the state of each door
# As array are indexed from zero, but as there is no door zero,
# we create an array of $doornCount+1 doors, and ignore door[0]
# A shut door is represented as 0, and an open door being not 0.

use strict;use warnings;

my $doorCount=500;

my @doors=(0)x($doorCount+1);          # $doorCount+1 doors

foreach my $doorman (1..$#doors) {     # each of the employees
    my $n=1;                           # multiples starting with one
    while ($doorman*$n<=($doorCount)){ # and continuing until no more doors
	                                   # toggles the door state (using 'not')
      $doors[$doorman*$n++]=not $doors[$doorman*$n]; 
    }
}

# print each open door;
foreach my $door (1..$#doors){
	print " ".$door if $doors[$door];  
}

print "\n";
# The results are interesting. The door will only stay open if it has an
# odd number of factors. Factors of a number generally occur as pairs
# that multiply together to produce that number...so the only way to get a 
# odd number of factors is when it possible for both the factors to be
# the same...i.e the number has to be a square number.
# the same results can therefore be obtained by: 

my $cheat=1;
print " ".($cheat++)**2 while $cheat<sqrt($doorCount);

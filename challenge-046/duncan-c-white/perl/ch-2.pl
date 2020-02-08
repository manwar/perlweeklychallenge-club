#!/usr/bin/perl
#
# Task #2: "Is the room open?
# 
# There are 500 rooms in a hotel with 500 employees having keys to all the
# rooms. The first employee opened main entrance door of all the rooms. The
# second employee then closed the doors of room numbers 2,4,6,8,10 and
# so on to 500. The third employee then closed the door if it was opened
# or opened the door if it was closed of rooms 3,6,9,12,15 and so on to
# 500. Similarly the fourth employee did the same as the third but only
# room numbers 4,8,12,16 and so on to 500. This goes on until all employees
# has had a turn.
# 
# Write a script to find out all the rooms still open at the end.
# "
# 
# My notes: sounds pretty easy, two nested for loops, but it's one of those
# questions where I can't predict what the answer will be.
# Wow!  the answer is: all the squares!  Let's find out why..
# 

use feature 'say';
use strict;
use warnings;

die "Usage: ch-2.pl [Nrooms]\n" if @ARGV>1;
my $n = shift // 500;

# all rooms open initially [we don't use element 0]
my @roomopen = ( 0, (1) x $n );

say "naive answer:";
foreach my $empl (2..$n)
{
	for( my $room=$empl; $room<=$n; $room+=$empl )
	{
		#say "debug: empl=$empl, room=$room, roomopen? $roomopen[$room]";
		$roomopen[$room] = 1-$roomopen[$room];
	}
}

my @open = grep { $roomopen[$_] } 0..$n;
say join(',', @open);

# ok, so a room no R is open at the end if the number of factors of R,
# including 1 and R, is ODD:

say "odd-factors answer:";
my @sq;
foreach my $r (1..$n)
{
	my $odd = 1;
	foreach my $i (2..$r)
	{
		$odd = ! $odd if $r % $i == 0;
	}
	push @sq, $r if $odd;
}
say join(',', @sq);

say "but why are the squares the only numbers with an odd number of factors?";

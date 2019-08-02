#!/usr/bin/perl
#
# Challenge 1: "Pythagoras Pie Puzzle, proposed by Jo Christian Oterhals.
# 
# At a party a pie is to be shared by 100 guest. The first guest gets 1%
# of the pie, the second guest gets 2% of the remaining pie, the third
# gets 3% of the remaining pie, the fourth gets 4% and so on.
# 
# Write a script that figures out which guest gets the largest piece of pie.
# "
# 
# My notes:
# 
# Beautifully clearly described.  Sounds straightforward.

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

die "Usage: ch-1.pl [N]\n" if @ARGV>1;
my $n = shift // 100;

my $percentleft = 100;
my $biggestpercent = 0;
my $guestwithbiggestpercent = 0;

foreach my $i (1..$n)
{
	my $pi = $i * $percentleft / 100;	# amount for guest i
	print "guest $i has $pi percent of the pie\n";
	if( $pi > $biggestpercent )
	{
		$biggestpercent = $pi;
		$guestwithbiggestpercent = $i;
	}
	$percentleft -= $pi;		# percentage left over
}

print "\nguest $guestwithbiggestpercent has biggest percentage of pie: ".
	"$biggestpercent\n";

#!/usr/bin/perl
#
# Challenge 2: "Write a program to solve the Knapsack Problem.
# 
# There are 5 color coded boxes with varying weights and amounts in
# GBP. Which boxes should be choosen to maximize the amount of money while
# still keeping the overall weight under or equal to 15 kgs?
# 
# R: (weight = 1 kg, amount = £1)
# B: (weight = 1 kg, amount = £2)
# G: (weight = 2 kg, amount = £2)
# Y: (weight = 12 kg, amount = £4)
# P: (weight = 4 kg, amount = £10)
# 
# Bonus task, what if you were allowed to pick only 2 boxes or 3 boxes or
# 4 boxes? Find out which combination of boxes is the most optimal?
# "
# 
# My notes: sounds interesting!
# Looking at the numbers and weights: Y is useless, very heavy and not worth
# much, we want maximum value, minimum weight.
# similarly, R is useless, as it weighs the same as B is not worth as much.
# I suspect 3xP worth £ 30 is a good place to start, and then 
# actually, G is useless as it has weight 2 x weight(B) and value value(B).
# That leaves only B (1kg, £ 2) and P (4kg ,£ 10), in which case 15kgs is
# 3 P + 3 B, for a value of £ 63.
# 
# But then why do we need a computer program?  we can work the answers out
# by hand..  so all that is left is nice formatting of the answers..

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
#use Data::Dumper;


my %data =		# maps box name -> [ unit weight, unit value ]
(
	"P" => [ 4, 10 ],
	"B" => [ 1,  2 ],
);


my $totalweight = 0;
my $totalvalue = 0;


#
# header( $msg );
#	Produce the header.
#
fun header( $msg )
{
	print "$msg:\n";
	print " Box  Quantity  Unit Weight  Weight  Unit Value  Value\n";
	$totalweight = 0;
	$totalvalue = 0;
}


#
# row( $box, $quantity );
#	Produce a single row of spreadsheet-style output.
#
fun row( $box, $quantity )
{
	my( $unitweight, $unitvalue ) = @{$data{$box}};
	my $w = $quantity*$unitweight;
	my $v = $quantity*$unitvalue;
	printf( " %2s    %4d     %5d kg     %3d kg      £%3d    £ %2d\n",
		$box, $quantity, $unitweight, $w, $unitvalue, $v );
	$totalweight += $w;
	$totalvalue += $v;
}


#
# total();
#	Produce the total.
#
fun total()
{
	printf( "%6s %8s  %10s  %3d kg  %9s   £%3d\n\n",
		" Total", "", "", $totalweight, "", $totalvalue );
}

header( "general" );
row( "P", 3 );
row( "B", 3 );
total();

header( "2 boxes" );
row( "P", 2 );
total();

header( "3 boxes" );
row( "P", 3 );
total();

header( "4 boxes" );
row( "P", 3 );
row( "B", 1 );
total();

#!/usr/bin/perl
#
# Task 1: "Stepping Numbers
# 
# Write a script to accept two numbers between 100 and 999. It should then
# print all Stepping Numbers between them.
# 
#     A number is called a stepping number if the adjacent digits have a
#     difference of 1. For example, 456 is a stepping number but 129 is not.
# "
#
# My notes: Sounds simple.
# 

use feature 'say';
use strict;
use warnings;
use Function::Parameters;
#use Data::Dumper;

die "Usage: stepping-nos [from [to]]\n" if @ARGV > 2;
my $from = shift // 100;
my $to   = shift // 999;


#
# my $isstepping = stepping( $x );
#	Return true iff $x is a stepping number in the sense of the question,
#	ie. one where the adjacent digits have a difference of 1. eg 456.
#
fun stepping( $x )
{
	my @digits = split(//,$x);
	my $prev = shift @digits;
	foreach my $next (@digits)
	{
		return 0 unless $next == $prev+1;
		$prev = $next;
	}
	return 1;
}


foreach my $n ($from..$to)
{
	say $n if stepping($n);
}

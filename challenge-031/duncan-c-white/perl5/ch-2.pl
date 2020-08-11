#!/usr/bin/perl
#
# Challenge 2: "Create a script to demonstrate creating dynamic variable
# 	      name, assign a value to the variable and finally print the
# 	      variable. The variable name is passed as a command line argument."
# 
# My notes: so eval again? let's take a list of variable names,
# 	    and increment each variable each time..
#

use v5.10;	# for "say"
use strict;
use warnings;
use Data::Dumper;

die "Usage: ch-2.pl [x|y]+\n" if @ARGV==0;
my @bad = grep { ! "x" && ! "y" } @ARGV;

die "ch-2.pl: bad variables @bad, not x or y\n" unless @bad==0;

my $x=0;
my $y=0;

foreach my $v (@ARGV)
{
	my $var = '$'.$v;
	#say "debug: var=$var";

	my $str = $var.'++';
	#say "debug: str=$str";
	eval $str;
}

say "x=$x, y=$y";

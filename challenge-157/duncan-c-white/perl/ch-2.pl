#!/usr/bin/perl
# 
# TASK #2 - Brazilian Number
# 
# You are given a number $n > 3.
# 
# Write a script to find out if the given number is a Brazilian Number.
# 
# A positive integer number N has at least one natural number B where
# 1 < B < N-1 where the representation of N in base B has same digits.
# 
# 
# Example 1:
# 
# 	Input: $n = 7
# 	Output: 1
# 
# 	Since 7 in base 2 is 111.
# 
# Example 2:
# 
# 	Input: $n = 6
# 	Output: 0
# 
# Since 6 in base 2 is 110,
#       6 in base 3 is 20 and
#       6 in base 4 is 12.
# 
# Example 3:
# 
# 	Input: $n = 8
# 	Output: 1
# 
# 	Since 8 in base 3 is 22.
# 
# MY NOTES: ok, so "same digits" really means "a single digit repeated
# throughout the entire string".  Sounds pretty easy.
# Added debugging mode to produce and display the "Since" messages,
# formatted nicely.  Then added tabulate mode to show the first N
# Brazilian numbers (this interoperates nicely with -d).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;

my $debug=0;
my $tabulate=0;
die "Usage: is-brazilian-number [--debug] [--tabulate] N\n" unless
	GetOptions( "debug" => \$debug, "tabulate" => \$tabulate ) && @ARGV==1;


#
# my $basestr = inbase($n,$b);
#	Return the "in base $b" representation of $n, as a string of
#	the form n1-n2-n3-....  Where n1 is the first base $b digit,
#	n2 the second and so on.  This avoids having to convert base $b
#	digits > 9 into a..z etc.
#
fun inbase( $n, $b )
{
	die "inbase($n,base $b): $b must be >1\n"
		if $b<2;

	my @x;
	while( $n>0 )
	{
		push @x, $n % $b;
		$n = int($n/$b);
	}
	return join('-',reverse @x);
}



#
# my $isrepeated = repeated($dashstr);
#	Return 1 if $dashstr is of the form x-x-x...x
#	for some value of x.  Otherwise return 0.
#
fun repeated( $dashstr )
{
	my @x = split(/-/, $dashstr);
	die "repeated: dashstr $dashstr has no '-'s\n"
		if @x==0;
	my $n = shift @x;
	foreach my $v (@x)
	{
		return 0 if $v != $n;
	}
	return 1;
}



#
# my( $isbraz, $sincemsg ) = isbrazilian( $n );
#	Return ( 1, mesg ) iff $n is a brazilian number, as defined
#	above.  Otherwise return ( 0, mesg ).  The message is the
#	"Since" message shown above in the examples, nicely formatted.
#
fun isbrazilian( $n )
{
	my @out;
	foreach my $b (2..$n-2)
	{
		my $basestr = inbase($n,$b);
		my $msg = "$n in base $b is $basestr";
		if( repeated($basestr) )
		{
			return (1, "Since $msg");
		}
		push @out, $msg;
	}
	my $wholemesg = "Since ". join(', ', @out). ".";
	$wholemesg =~ s/, ([^,]+)$/ and $1/;
	$wholemesg =~ s/,/\n     /g;
	$wholemesg =~ s/ and / and\n      /g;
	return (0, $wholemesg );
}


my $n = shift;
die "brazilian-number: n ($n) must be > 3\n" unless $n>3;

if( $tabulate )
{
	my $found=0;
	for( my $i=4; $found<$n; $i++ )
	{
		my( $isbraz, $sincemesg ) = isbrazilian( $i );
		next unless $isbraz;
		say "$i is brazilian";
		say "    $sincemesg" if $debug;
		$found++;
	}
} else
{
	my( $isbraz, $sincemesg ) = isbrazilian( $n );
	say "Input $n";
	say "Output $isbraz";
	say $sincemesg if $debug;
}

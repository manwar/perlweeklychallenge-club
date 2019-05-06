#!/usr/bin/perl

# Challenge 1: "Create a script which takes a list of numbers from
# command line and print the same in the compact form. For example, if
# you pass 1,2,3,4,9,10,14,15,16 then it should print the compact form
# like 1-4,9,10,14-16.."

use strict;
use warnings;
use Data::Dumper;

die "Usage: ch-1.pl list_of_numbers\n" if @ARGV == 0;

my $minlen = 3;
my @in = @ARGV;

my @out;

while( @in )
{
	my $s = shift @in;	 # new sequence s..s
	my $e = $s;
	while( @in && $in[0] == $e+1 )
	{
		$e = shift @in;
	}
	#print "s=$s, e=$e\n";
	push @out,
		(( $e-$s+1 >= $minlen ) ?
		"$s-$e" :
		join( ',', $s..$e ));
}
print join(',',@out)."\n";

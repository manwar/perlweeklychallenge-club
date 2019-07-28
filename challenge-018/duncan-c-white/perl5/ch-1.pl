#!/usr/bin/perl
#
# Challenge 1: "Write a script that takes 2 or more strings as command
# line parameters and print the longest common substring. For example,
# the longest common substring of the strings "ABABC", "ABCA" 
# and "BCBA" is string "BC" of length 3.
# "
# 
# My notes:
# 
# Very clearly described.  No obvious clever way of solving this, but the
# basic method is simple.

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

die "Usage: ch-1.pl STR1 STR2 [STR3...]N\n" unless @ARGV>1;

#
# my $is = substr_of_all( $s, @str );
#	Calculate whether or not $s is a substr of every string in @str.
#	Return true iff it is; false otherwise.
#
fun substr_of_all( $s, @str )
{
	foreach my $str (@str)
	{
		return 0 unless $str =~ /$s/i;
	}
	return 1;
}


#
# my $longestsubstr = find_longest_substr( @str );
#	Find and return the longest substring of an array of strings @str.
#
fun find_longest_substr( @str )
{
	# find the shortest string
	my $shortest;
	my $shortlen = length($str[0])+1;
	foreach my $str (@str)
	{
		my $l = length($str);
		if( $l < $shortlen )
		{
			$shortlen = $l;
			$shortest = $str;
		}
	}
	#print "found shortest string: $shortest\n";
	return $shortest if substr_of_all( $shortest, @str );

	# otherwise try, in order of length, each substring of $shortest
	for( my $l=$shortlen-1; $l>0; $l-- )
	{
		#print "trying length $l substrings of $shortest\n";
		for( my $pos=$shortlen-$l; $pos>=0; $pos-- )
		{
			my $sub = substr($shortest,$pos,$l);
			#print " checking whether $sub is a substring of all\n";
			my $is = substr_of_all( $sub, @str );
			return $sub if $is;
		}
	}

	return "";
}


my @str = @ARGV;
my $longestsubstr = find_longest_substr( @str );
print "longest sub string of strings is $longestsubstr\n";

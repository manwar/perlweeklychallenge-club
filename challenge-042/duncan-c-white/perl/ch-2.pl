#!/usr/bin/perl
#
# Task #2: "Balanced Brackets
# 
# Write a script to generate a string with random number of ( and ) brackets. Then make the script validate the string if it has balanced brackets.
# 
# For example:
# () - OK
# (()) - OK
# )( - NOT OK
# ())() - NOT OK
# "
# 
# My notes: sounds quite easy. Generate is like coin tossing, validator
# could either count how many nested brackets we're in, or we could use
# regex search and replace to repeatedly delete () pairs of adjacent
# characters, valid if we end up with the empty string.
# 

use v5.10;	# to get "say"
use strict;
use warnings;
#use Data::Dumper;


#
# my $brackstr = gen_bracketed_string();
#	Generate a bracketed string which may or may not
#	be balanced.
#
sub gen_bracketed_string
{
	my $len = 20+int(rand(20));
	my $result="";
	foreach (1..$len)
	{
		$result .= int(rand(2))==0?'(':')';
	}
	return $result;
}


#
# my $isvalid = validate( $brackstr );
#	Return 1 iff $brackstr is valid, i.e. contains matching
#	brackets. Else return 0.
#
sub validate
{
	my( $brackstr ) = @_;
	my( $origlen, $len );
	do
	{
		$origlen = length($brackstr);
		$brackstr =~ s/\(\)//g;
		$len = length($brackstr);
	} while( $len < $origlen );
	return $len==0?1:0;
}


srand( $$ ^ time() );

die "Usage: ch-2.pl [BRACKSTR]\n" if @ARGV>1;
my $brackstr = shift // gen_bracketed_string();

my $isvalid = validate( $brackstr );

say "$brackstr valid? $isvalid";

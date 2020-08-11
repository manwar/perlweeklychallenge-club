#!/usr/bin/perl
#
# Challenge 1: "Create a function to check divide by zero error without
#	      checking if the denominator is zero."
#
# My notes: so eval then?
# 

use v5.10;	# to get "say"
use strict;
use warnings;

die "Usage: ch-1.pl a b\n" unless @ARGV==2;
my $a = shift;
my $b = shift;

my $x;
if( defined eval { $x = $a / $b } )
{
	say "$a / $b = $x";
} else
{
	say "error: $@";
}

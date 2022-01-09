#!/usr/bin/perl
# 
# TASK #2 - Curious Fraction Tree
# 
# Consider the following Curious Fraction Tree:
# 
# [diagram in which the root is 1/1, and for each element N/D
# it's right child is N+D/D, and it's left child is N/N+D]
# 
# You are given a N/D member of the tree created similar to the above sample.
# 
# Write a script to find out the parent and grandparent of the given member.
# 
# Example 1:
# 
#     Input: $member = '3/5';
#     Output: parent = '3/2' and grandparent = '1/2'
# 
# Example 2:
# 
#     Input: $member = '4/3';
#     Output: parent = '1/3' and grandparent = '1/2'
# 
# MY NOTES: hmm..  having determined the left and right child rules
# above, I worked out that given a child N/D the parent rule is
# "if D>N then (N, D-N) else (N-D, D)"
# 
# So very easy using that rule twice (and why not go all the way up to
# the root while we're doing it).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Function::Parameters;


my $debug=0;


die "Usage: curious-fraction-tree-ancestors [--debug] N/D\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $s = shift;

die "cft: bad N/D string $s\n" unless $s =~ m|^(\d+)/(\d+)$|;
my( $n, $d ) = ( $1, $2 );

my $label = "parent";

while( $n>0 && $d>0 )
{
	# change (n,d) to parent(n,d)
	if( $d > $n )
	{
		$d -= $n;
	} else
	{
		$n -= $d;
	}
	say "$label: $n/$d" if $n>0 && $d>0;
	$label = "grand$label";
}

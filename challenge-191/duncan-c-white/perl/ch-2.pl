#!/usr/bin/perl
# 
# Task 2: Cute List
# 
# You are given an integer, 0 < $n <= 15.
# 
# Write a script to find the number of orderings of numbers that form a cute list.
# 
# With an input @list = (1, 2, 3, .. $n) for positive integer $n, an
# ordering of @list is cute if for every entry, indexed with a base index of
# 1, either
# 
# 1) $list[$i] is evenly divisible by $i
# or
# 2) $i is evenly divisible by $list[$i]
# 
# Example
# 
# Input: $n = 2
# Ouput: 2
# 
# Since $n = 2, the list can be made up of two integers only i.e. 1 and 2.
# Therefore we can have two list i.e. (1,2) and (2,1).
# 
# @list = (1,2) is cute since $list[1] = 1 is divisible by 1 and $list[2]
# = 2 is divisible by 2.
# 
# MY NOTES: Hmm.. isn't every number divisible by 1, doesn't that mean that
# the list[1] check is unnecessary?  Looks weird but otherwise reasonably
# straightforward.  Obviously need a "next permutation of the list" iterator,
# reusing the one from Challenge 134, adapted slightly.
#
# My results: dunno if I'm doing it right, but here at my results for N=1..10:
# 1: 1
# 2: 2
# 3: 3
# 4: 8
# 5: 10
# 6: 36
# 7: 41
# 8: 132
# 9: 250
# 10: 700
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;


my $debug=0;
die "Usage: cute-list [--debug] N (1..15)\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $n = shift;

die "cute-list: N ($n) must be in range 1..15)\n"
	unless $n>0 && $n<16;

#
# my @next = next_perm( @a );
#	Find and return the next permutation in lexicographic order
#	of @arr.  Return () if $val is the last permutation (in order).
#	Algorithm is as follows:
#	1. Find the largest index k such that a[k] < a[k + 1]. If no such index exists,
#	   the permutation is the last permutation.
#       2. Find the largest index l greater than k such that a[k] < a[l].
#       3. Swap the value of a[k] with that of a[l].
#       4. Reverse the sequence from a[k + 1] up to and including the final element a[n].
#
fun next_perm( @a )
{
	my( $k, $l );
	my $n = @a-1;
	for( $k=$n-1; $k>=0 && $a[$k]>=$a[$k+1]; $k-- )
	{
	}
	return () if $k<0;
	for( $l=$n; $l>$k && $a[$k]>=$a[$l]; $l-- )
	{
	}
	( $a[$k], $a[$l] ) = ( $a[$l], $a[$k] );

	# reverse a[k+1]..a[n]
	@a[$k+1..$n] = reverse @a[$k+1..$n];

	return @a;
}


=pod

=head2 my $iscute = is_cute(@list);

Return 1 iff @list is cute, as in the top spec.  Return 0 otherwise.

=cut
fun is_cute( @list )
{
	foreach my $i0 (0..$#list)
	{
		my $index = $i0+1;	# index base at 1
		my $val = $list[$i0];
		# NOT cute if both are NOT evenly disible by tother
		return 0 if ( $val % $index != 0 ) && ( $index % $val != 0 );
	}
	return 1;
}


my @list = (1..$n);
say "initial list: ", join(',',@list) if $debug;

my $ncute = 0;

for( my $i=1; ; $i++ )
{
	last if @list==0;
	#say "perm $i: ", join(',',@list);
	if( is_cute(@list) )
	{
		say "cute perm: ", join(',',@list) if $debug;
		$ncute++;
	}
	@list = next_perm( @list );
}

say $ncute;

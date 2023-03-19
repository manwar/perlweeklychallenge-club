#!/usr/bin/perl
# 
# Task 1: Minimum Index Sum
# 
# You are given two arrays of strings.  Write a script to find out all
# common strings in the given two arrays with minimum index sum. If no
# common strings are found returns an empty list.
# 
# Example 1
# 
# Input: @list1 = ("Perl", "Raku", "Love")
#        @list2 = ("Raku", "Perl", "Hate")
# 
# Output: ("Perl", "Raku")
# 
# There are two common strings "Perl" and "Raku".
# Index sum of "Perl": 0 + 1 = 1
# Index sum of "Raku": 1 + 0 = 1
# 
# Example 2
# 
# Input: @list1 = ("A", "B", "C")
#        @list2 = ("D", "E", "F")
# 
# Output: ()
# 
# No common string found, so no result.
# 
# Example 3
# 
# Input: @list1 = ("A", "B", "C")
#        @list2 = ("C", "A", "B")
# 
# Output: ("A")
# 
# There are three common strings "A", "B" and "C".
# Index sum of "A": 0 + 1 = 1
# Index sum of "B": 1 + 2 = 3
# Index sum of "C": 2 + 0 = 2
# 
# MY NOTES: very easy.  Identify whether any common strings exist: set
# intersection.  Then calculate index sum of all common strings and choose
# the minimum ones.  Trickiest thing to work out is how to input two lists
# of strings - let's assume that they come as two command line args eg.
# A,B,C and C,A,B
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl into C
# (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: mis [--debug] word-list word-list\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;

my( $list1, $list2 ) = @ARGV;
my @list1 = split( /,/, $list1 );
my @list2 = split( /,/, $list2 );

#say "list1: ", join(',',@list1) if $debug;
#say "list2: ", join(',',@list2) if $debug;

my %set1 = map { $_ => 1 } @list1;

# my $sum = indexsum( $word, \@list1, \@list2 );
#	Calculate and return the index sum of $word in the two lists.
#
sub indexsum
{
	my( $word, $list1, $list2 ) = @_;
	my $sum = 0;
	foreach my $pos (0..$#$list1)
	{
		$sum += $pos if $list1[$pos] eq $word;
	}
	foreach my $pos (0..$#$list2)
	{
		$sum += $pos if $list2[$pos] eq $word;
	}
	return $sum;
}

my @common = grep { $set1{$_} } @list2;
my $nc = @common;
say "There are $nc common strings: ", join(',',@common) if $debug;

my $mis = @list1 + @list2;
my @best = ();
foreach my $w (@common)
{
	my $s = indexsum( $w, \@list1, \@list2 );
	say "The index sum of $w is $s" if $debug;
	if( $s < $mis )
	{
		$mis = $s;
		@best = ($w);
	} elsif( $s == $mis )
	{
		push @best, $w;
	}
}

say "(", join(',', map { qq("$_") } @best ), ")";

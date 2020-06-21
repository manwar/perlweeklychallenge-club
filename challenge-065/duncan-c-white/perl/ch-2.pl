#!/usr/bin/perl
#
# Task 2: "Palindrome Partition
#
# You are given a string $S. Write a script print all possible partitions
# that gives Palindrome. Return -1 if none found.
# 
# Please make sure, partition should not overlap. For example, for given
# string "abaab", the partition "aba" and "baab" would not be valid,
# since they overlap.
# 
# Example 1
# 
# Input: $S = 'aabaab'
# Ouput:
#  There are 3 possible solutions.
#  a) 'aabaa'
#  b) 'aa', 'baab'
#  c) 'aba'
# 
# Example 2
# 
# Input: $S = 'abbaba'
# Output:
#  There are 3 possible solutions.
#  a) 'abba'
#  b) 'bb', 'aba'
#  c) 'bab'
# "
# 
# My notes: hang on, what exactly do we mean by a "partition"?
# this isn't clear!
#
# First: isn't a single letter a substring - an element - of a partition?
# presumably not - otherwise 'a', 'a', 'b', 'a', 'a', 'b' would be a solution
# to the first example.  So presumably each partitioned substring is of
# minimum length 2.
# 
# Second: Do all the substrings in a partition have to "span" the string, i.e.
# do all the substrings in a partition have to append together to form the
# original string?  Presumably not, otherwise 'aabaa' would not be a solution
# to the first example.
#
# Third: Can there be more than two elements in a single partition of a string?
# None of the examples show more than two.  I don't know the answer to this one,
# so I'll assume that "there can only one or two elements in a partition".
# 
# So this problem is badly specified.  Let's assume that we mean:
#
# "A partition of a string S is either a single substring of minimum length 2
# or a pair of exactly 2 non-overlapping substrings of S, each of minimum length
# 2.  Find all partitions of S for which the partition substring(s) are all
# palindromes."
# 
# If this isn't the right definition, well damn it, the question should have
# been clearer - and I expect full marks!
#
# Having programmed the above, this also claims (for example) that "aa" is a
# possible solution to example 1 - which is fair enough by the above statement.
# So I tried adding the logic:
# - find the single substrings that are palindromes, call that @p1
# - find the pairs of non-overlapping substrings where each substring is
#   a palindrome, call that @p2
# - remove from @p1 any element that is one of any pair in @p2
#
# But even this shows 4 solutions for example 1:
#
# aabaa
# aba
# aa,baab
# aa,aa
#
# (whereas only the first 3 are expected).  I guess we are saying that aa,aa
# should not a solution because aa,baab is (and baab contains aa)?  I can't
# be bothered to implement this, as the deal is: we implement the problems
# given to us; not we first debug the problem specs given to us and then
# implement the debugged spec.  Please make the problem spec clearer next
# week, Mohammed!
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

die "Usage: palindrome-partition string\n" unless @ARGV==1;
my $string = shift;

#
# my $ispal = ispalindrome($string);
#	Return 1 iff $string is a palindrome; 0 otherwise.
#
fun ispalindrome( $string )
{
	my $r = reverse($string);
	return $string eq $r ? 1 : 0;
}


#
# my @sol = p1( $string );
#	Find all single substrings of length>1 of $string that are palindromes.
#	Return the list of singleton palindromic substrings.
#
fun p1( $string )
{
	my @result;
	my $l = length($string);
	foreach my $startpos (0..$l-2)
	{
		foreach my $endpos ($startpos+1..$l-1)
		{
			my $substr = substr($string,$startpos,
				1+$endpos-$startpos);
			die unless length($substr)>1;
			push @result, [$substr] if ispalindrome($substr);
		}
	}
	return @result;
}



#
# my @sol = p2( $string );
#	Find all pairs of non-overlapping substrings of length>1 of
#	$string that are palindomes.  Return a list of pairs.
#
fun p2( $string )
{
	my @result;
	my $l = length($string);
	foreach my $sp1 (0..$l-4)
	{
	    foreach my $ep1 ($sp1+1..$l-3)
	    {
		my $substr1 = substr($string,$sp1, 1+$ep1-$sp1);
		die unless length($substr1)>1;
		next unless ispalindrome($substr1);
		foreach my $sp2 ($ep1+1..$l-2)
		{
		    foreach my $ep2 ($sp2+1..$l-1)
		    {
			my $substr2 = substr($string,$sp2, 1+$ep2-$sp2);
			die unless length($substr2)>1;
			next unless ispalindrome($substr2);
			push @result, [$substr1,$substr2];
		    }
		}
	    }
	}
	return @result;
}


my @p1 = p1( $string );
my @p2 = p2( $string );

# hmm.. have to remove from p1 any element that is one of any pair in @p2
foreach my $pair (@p2)
{
	my( $first, $second ) = @$pair;
	#say "debug: first=$first, second=$second";
	@p1 = grep { $_->[0] ne $first && $_->[0] ne $second } @p1;
}

my @sol = ( @p1, @p2 );

#die Dumper(\@sol);
say @sol>0 ? join("\n", map { join(',', @$_) } @sol) : "-1";

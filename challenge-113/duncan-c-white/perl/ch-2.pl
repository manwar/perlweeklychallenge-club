#!/usr/bin/perl
# 
# Task 2: "Recreate Binary Tree
# 
# You are given a Binary Tree.
# 
# Write a script to replace each node of the tree with the sum of all the remaining nodes.
# 
# Example
# Input Binary Tree
# 
#         1
#        / \
#       2   3
#      /   / \
#     4   5   6
#      \
#       7
# 
# Output Binary Tree
# 
#         27
#        /  \
#       26  25
#      /   /  \
#     24  23  22
#      \
#      21
# "
# 
# My notes: so each node's value X becomes sum(allnodes) - X.
# It's very tempting to view this as an ascii art -> ascii art problem, as last
# time we did a similar tree question, I spent a lot of time building the tree
# structure, and getting nice layout from print_tree..  so let's find another way.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use List::Util qw(sum);
#use Data::Dumper;

#
# my $n = sumnumbers( $line );
#	Find all numeric sequences in $line and sum them up.
#	Return the answer.
#
fun sumnumbers( $line )
{
	$line =~ s|\D+| |g;
	$line =~ s|\s+| |g;
	$line =~ s|^\s+||;
	$line =~ s|\s+$||;
	return 0 unless $line =~ /\d/;
	my $total = sum( split( /\s+/, $line ) );
	return $total;
}


#
# my $str = rewritenumbers( $sum, $line );
#	Rewrite every number found in $line as $sum-THAT number.
#	Return the modified string.
#
fun rewritenumbers( $sum, $line )
{
	$line .= " ";
	$line =~ s/(\d+) /$sum-$1/eg;
	return $line;
}



my @tree = <>;
chomp @tree;
my @n = map { sumnumbers($_) } @tree;
my $sum = sum( @n );
#say "total=$sum";

say rewritenumbers($sum,$_) for @tree;

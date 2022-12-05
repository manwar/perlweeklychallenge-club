#!/usr/bin/perl
# 
# Task 2: Odd String
# 
# You are given a list of strings of same length, @s.
# 
# Write a script to find the odd string in the given list. Use positional
# value of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.
# 
# Find the difference array for each string as shown in the example. Then
# pick the odd one out.
# 
# Example 1:
# 
# Input: @s = ("adc", "wzy", "abc")
# Output: "abc"
# 
# Difference array for "adc" => [ d - a, c - d ]
#                            => [ 3 - 0, 2 - 3 ]
#                            => [ 3, -1 ]
# 
# Difference array for "wzy" => [ z - w, y - z ]
#                            => [ 25 - 22, 24 - 25 ]
#                            => [ 3, -1 ]
# 
# Difference array for "abc" => [ b - a, c - b ]
#                            => [ 1 - 0, 2 - 1 ]
#                            => [ 1, 1 ]
# 
# The difference array for "abc" is the odd one.
# 
# Example 2:
# 
# Input: @s = ("aaa", "bob", "ccc", "ddd")
# Output: "bob"
# 
# Difference array for "aaa" => [ a - a, a - a ]
#                            => [ 0 - 0, 0 - 0 ]
#                            => [ 0, 0 ]
# 
# Difference array for "bob" => [ o - b, b - o ]
#                            => [ 14 - 1, 1 - 14 ]
#                            => [ 13, -13 ]
# 
# Difference array for "ccc" => [ c - c, c - c ]
#                            => [ 2 - 2, 2 - 2 ]
#                            => [ 0, 0 ]
# 
# Difference array for "ddd" => [ d - d, d - d ]
#                            => [ 3 - 3, 3 - 3 ]
#                            => [ 0, 0 ]
# 
# The difference array for "bob" is the odd one.
# 
# MY NOTES: Hmm..  not always a single odd one out.  What are we supposed
# to do if there is no odd one out?
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;


my $debug=0;
die "Usage: odd-string [--debug] stringlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

=pod

=head2 my $diffsig = diffsig($str);

Given an alphabetic string $str, form the difference signature.

=cut
fun diffsig( $str )
{
	my @x = split( //, $str );
	my @diff;
	foreach my $pos (0..$#x-1)
	{
		push @diff, ord($x[$pos+1])-ord($x[$pos]);
	}
	return join( ',', @diff );
}


my @list = @ARGV;

my @diffsig = map { diffsig($_) } @list;

my %d2l;	# diffsig -> list of all strings with that diffsig
foreach my $pos (0..$#list)
{
	my $ref = ($d2l{ $diffsig[$pos] } //= []);
	push @$ref, $list[$pos];
}

#say for @diffsig;
#say Dumper(\%d2l);

my %freq;
map { $freq{$_}++ } @diffsig;

foreach my $k (keys %freq)
{
	delete $freq{$k} if $freq{$k}>1;
}

foreach my $k (keys %freq)
{
	my $ref = $d2l{$k};
	say join(',', @$ref);
}

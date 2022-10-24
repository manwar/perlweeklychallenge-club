#!/usr/bin/perl
# 
# Task 2: Magical Triplets
# 
# You are given a list of positive numbers, @n, having at least 3 numbers.
# 
# Write a script to find the triplets (a, b, c) from the given list that
# satisfies the following rules.
# 
# 1. a + b > c
# 2. b + c > a
# 3. a + c > b
# 4. a + b + c is maximum.
# 
# In case, you end up with more than one triplets having the maximum then
# pick the triplet where a >= b >= c.
# 
# Example 1
# 
#     Input: @n = (1, 2, 3, 2);
#     Output: (3, 2, 2)
# 
# Example 2
# 
#     Input: @n = (1, 3, 2);
#     Output: ()
# 
# Example 3
# 
#     Input: @n = (1, 1, 2, 3);
#     Output: ()
# 
# Example 4
# 
#     Input: @n = (2, 4, 3);
#     Output: (4, 3, 2)
# 
# MY NOTES: Ok, sounds like generate+test.  Find all triples. Find
# triples that pass tests (1)..(3).  Then find which triples have the
# maximum sum.  If only, that's the answer.  If more than one, use the
# tie break rule.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use feature 'state';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: magic-triple [--debug] csvlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $csvlist = shift;
my @x = split( /,/, $csvlist );

die "magic-triple: csvlist $csvlist must contain at least 3 numbers\n"
	unless @x>2;

# pass 1 - generate all triples of 3 distinct elements in @x (in any order)
# and find those triples that pass rules (1)..(3)

my %seentriple;	# a+b+c triples we've already seen
		# (only needed because of duplicate elements)

foreach my $p1 (0..$#x)
{
	foreach my $p2 (0..$#x)
	{
		next if $p1==$p2;
		foreach my $p3 (0..$#x)
		{
			next if $p1==$p3 || $p2==$p3;
			my $a = $x[$p1];
			my $b = $x[$p2];
			my $c = $x[$p3];
			next unless $a + $b > $c;
			next unless $b + $c > $a;
			next unless $a + $c > $b;
			next if $seentriple{"$a+$b+$c"}++;
			say "1..3 semi-magic triple $a, $b, $c" if $debug;
		}
	}
}

my @p1t = sort keys %seentriple;

# if there are NO triplets found obeying rules 1..3, report failure
if( @p1t == 0 )
{
	say "No magic triplets found";
	exit 0;
}

# pass 2: sort the triples by their sum into @st, then extract those (at
#	  the front of @st now) with the maximum sum.
my @st = sort { $b->[0] <=> $a->[0] } map { [ eval($_), $_ ] } @p1t;
my $maxval = $st[0]->[0];
my @maxsumt = map { $st[$_]->[1] } grep { $st[$_]->[0] == $maxval } 0..$#st;

# pass 3: identify which of those triples has a>=b>=c
foreach my $t (@maxsumt)
{
	$t =~ /^(\d+)\+(\d+)\+(\d+)$/;
	my( $a, $b, $c ) = ( $1, $2, $3 );
	next unless $a>=$b && $b>=$c; 
	$t =~ s/\+/, /g;
	say "Found magic triple $t";
}

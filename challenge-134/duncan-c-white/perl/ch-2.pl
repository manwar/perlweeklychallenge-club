#!/usr/bin/perl
# 
# TASK #2 - Distinct Terms Count
# 
# You are given 2 positive numbers, $m and $n.
# 
# Write a script to generate multiplication table and display count of distinct terms.
# 
# Example 1
# 
# Input: $m = 3, $n = 3
# Output:
# 
#       x | 1 2 3
#       --+------
#       1 | 1 2 3
#       2 | 2 4 6
#       3 | 3 6 9
# 
# Distinct Terms: 1, 2, 3, 4, 6, 9
# Count: 6
# 
# Example 2
# 
# Input: $m = 3, $n = 5
# Output:
# 
#       x | 1  2  3  4  5
#       --+--------------
#       1 | 1  2  3  4  5
#       2 | 2  4  6  8 10
#       3 | 3  6  9 12 15
# 
# Distinct Terms: 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15
# Count: 11
# 
# MY NOTES: Pretty easy, the distinct terms just need a set (hash) as usual.
# The tricky bit is the pretty layout of the multiplication table, especially
# getting the correct column widths..
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;

die "Usage: distinct-terms-count [-d|--debug] M N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;
my( $m, $n ) = @ARGV;
my $table = form_table( $m, $n );
say $table;

# Build the distinct values.. messy to do this while formatting the table..
my %distinct;
for( my $i=1; $i<=$m; $i++ )
{
	for( my $j=1; $j<=$n; $j++ )
	{
		$distinct{$i*$j}++;
	}
}
my @distinct = sort { $a <=> $b } keys %distinct;
my $count = @distinct;

say "Distinct Terms: ". join(', ', @distinct);
say "Count: $count";


#
# my $table = form_table( $m, $n );
#	Form a neatly formatted times table for $m rows x $n columns,
#	and return the single $m+2 line string. 
#
fun form_table( $m, $n )
{
	my $width = 1 + int( log($n*$m)/log(10) );
	my $firstw = 1 + int(log($m)/log(10));

	my @result;

	my $row = sprintf("%${firstw}s", "x") . " | ";
	$row .= sprintf("%${firstw}d ", 1 );
	$row .= sprintf("%${width}d ", $_ ) for 2..$n;
	push @result, $row;

	$row = '-'x($firstw+1)."+".('-'x($firstw+$width*($n-1)+$n));
	push @result, $row;

	for( my $i=1; $i<=$m; $i++ )
	{
		$row = sprintf("%${firstw}d", $i). " | ";
		$row .= sprintf("%${firstw}d ", $i );
		$row .= sprintf("%${width}d ", $i*$_ ) for 2..$n;
		push @result, $row;
	}

	return join("\n", @result);
}

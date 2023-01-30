#!/usr/bin/perl
# 
# Task 2: Seven Segment 200
# Submitted by: Ryan J Thompson
# 
# A seven segment display is an electronic component, usually used to
# display digits. The segments are labeled 'a' through 'g' as shown:
# 
#      a
#     --- 
#    |   |
#  f |   | b
#    | g |
#     --- 
#    |   |
#  e |   | c
#    | d |
#     --- 
#  
# Seven Segment
# 
# The encoding of each digit can thus be represented compactly as a truth table:
# 
# my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
# 
# For example, $truth[1] = "bc". The digit 1 would have segments "b" and "c"
# enabled.
# 
# Write a program that accepts any decimal number and draws that number
# as a horizontal sequence of ASCII seven segment displays, similar to
# the following:
# 
# -------  -------  -------
#       |  |     |  |     |
#       |  |     |  |     |
# -------
# |        |     |  |     |
# |        |     |  |     |
# -------  -------  -------
# 
# To qualify as a seven segment display, each segment must be drawn (or
# not drawn) according to your @truth table.
# 
# The number "200" was of course chosen to celebrate our 200th week!
# 
# MY NOTES: not quite so easy, but doable.
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
die "Usage: 7-segment [--debug] N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV == 1;
my $n = shift;

my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;


=pod
=head2 append_blank( $result );

Append a blank canvas 9 chars wide to @$result,
ready for drawing a 7-segment digit on top of.

=cut
fun append_blank( $result )
{
	foreach my $i (0..$#$result)
	{
		$result->[$i] .= "         ";
	}
}


=pod
=head2 hline( $result, $sx, $ex, $row );

Draw a horizontal line into the last 9 chars of @$result 
from (sx,y) to (ex,y).

=cut
fun hline( $result, $sx, $ex, $y )
{
	my $l = length($result->[0]);
	for( my $i=$sx; $i<=$ex; $i++ )
	{
		substr( $result->[$y], $l-9+$i, 1 ) = '-';
	}
}


=pod
=head2 vline( $result, $x, $sy, $ey );

Draw a vertical line into the last 9 chars of @$result 
from (x,sy) to (x,ey).

=cut
fun vline( $result, $x, $sy, $ey )
{
	my $l = length($result->[0]);
	for( my $i=$sy; $i<=$ey; $i++ )
	{
		substr( $result->[$i], $l-9+$x, 1 ) = '|';
	}
}


=pod
=head2 append_digit( $digit, $result );

Append the 7-segment version of $digit to @$result

=cut
fun append_digit( $digit, $result )
{
	append_blank( $result );
	my $bitmap = $truth[$digit];

	hline( $result, 1, 5, 0 ) if $bitmap =~ /a/;
	vline( $result, 6, 1, 2 ) if $bitmap =~ /b/;
	vline( $result, 0, 1, 2 ) if $bitmap =~ /f/;
	hline( $result, 1, 5, 3 ) if $bitmap =~ /g/;
	vline( $result, 6, 4, 5 ) if $bitmap =~ /c/;
	vline( $result, 0, 4, 5 ) if $bitmap =~ /e/;
	hline( $result, 1, 5, 6 ) if $bitmap =~ /d/;
}


my @result = ("") x 7;
#die Dumper(\@result);

foreach my $digit (split(//,$n))
{
	append_digit( $digit, \@result );
}

say for @result;

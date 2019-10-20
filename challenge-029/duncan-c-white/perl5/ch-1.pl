#!/usr/bin/perl
#
# Challenge 1: "Write a script to demonstrate brace expansion. For example,
# script would take command line argument Perl {Daily,Weekly,Monthly,Yearly}
# Challenge and should expand it and print like below:
# 
#   Perl Daily Challenge
#   Perl Weekly Challenge
#   Perl Monthly Challenge
#   Perl Yearly Challenge
# 
# My notes: Nested braces may be slightly tricky, first I tried a recursive
# function to find and expand the innermost {}, but that produced the
# right output in a weird order, with duplicates.
# Instead, try a state machine to track the locations of the outer level
# elements {,}.  Extract $before, $after and an array of alternatives @alt,
# then recombine them, until there are no { left.
# 

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

die "Usage: ch-1.pl STRING+\n" unless @ARGV == 1;
my $string = shift;

my @strings = expand_braces( $string );
#my @pos = find_outermost_posns( $string );
#say Dumper \@pos;
say for @strings;


#
# my @strings = expand_braces( $string );
#	Expand brace pairs in $string, giving an array of strings.
#
fun expand_braces( $string )
{
	my @pos = find_outermost_posns( $string );
	#say Dumper \@pos;
	return ( $string ) if @pos==0;
	my( $before, $after, @alt ) = extract_pieces( $string, @pos );
	#die "debug: before=$before, after=$after, alt=@alt\n";
	my @result;
	foreach my $alt (@alt)
	{
		my $s = $before.$alt.$after;
		push @result, expand_braces( $s );
	}
	return @result;
}  


#
# my( $before, $after, @alt ) = extract_pieces( $string, @pos );
#	Extract the before part of $string, and the after
#	part, and the array of altneratives.
#
fun extract_pieces( $string, @pos )
{
	my( $p, $c ) = @{shift @pos};
	die "extrace_pieces: first pos $p, char $c not {\n" unless $c eq '{';
	my $before = substr($string,0,$p);
	#print "debug: before=$before, p=$p, c=$c\n";
	my $start = $p;
	my @alt;
	my $after;
	foreach my $pc (@pos)
	{
		my( $p, $c ) = @$pc;
		if( $c eq ',' || $c eq '}' )
		{
			my $frag = substr($string,$start+1,$p-$start-1);
			push @alt, $frag;
			$start = $p;
			if( $c eq '}' )
			{
				$after = substr($string,$p+1);
				#print "debug: before=$before, after=$after, alt=@alt\n";
				return ( $before, $after, @alt );
			}
		}
	}
	die "extrace_pieces: no } found{\n";
}


#
# my @pos = find_outermost_posns( $string );
#	Locate the char positions in $string of:
#	any '{', ',', '}' characters (not nested).
#	Return the array of char positions, or an
#	empty array if the string doesn't contain
#	a '{'.
#
# How? a state machine to track the locations of the outer level {,}:
# 
#	s0: NOTE POS and enter s1 when '{'
#	s1: N=1; enter s2 when '{'
#           NOTE POS when ','
#	    NOTE pos and enter s0 when '}'
#	s2: N++ when '{'
#	    N--; enter s1 if N==0 when '}'
# 
fun find_outermost_posns( $string )
{
	my @result;
	my $state = 0;
	my $state2n = 0;
	for( my $pos = 0; $pos < length($string); $pos++ )
	{
		my $ch = substr($string,$pos,1);
		#print "debug: pos=$pos, ch=$ch, state=$state, state2n=$state2n\n";
		if( $state == 0 )		# not in {
		{
			if( $ch eq '{' )
			{
				push @result, [ $pos, $ch ];
				$state = 1;
			}
		} elsif( $state == 1 )		# inside exactly one {
		{
			if( $ch eq ',' )
			{
				push @result, [ $pos, $ch ];
			} elsif( $ch eq '{' )
			{
				$state2n = 1;
				$state = 2;
			} elsif( $ch eq '}' )
			{
				push @result, [ $pos, $ch ];
				$state = 0;
			}
		} elsif( $state == 2 )		# inside >1 {
		{
			if( $ch eq '{' )
			{
				$state2n++;
			} elsif( $ch eq '}' )
			{
				$state2n--;
				if( $state2n == 0 )
				{
					$state = 1;
				}
			}
		}
	}
	return @result;
}

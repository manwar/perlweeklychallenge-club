#!/usr/bin/perl
#
# Task 1: "Square Secret Code:
#
# The square secret code mechanism first removes any space from the original
# message. Then it lays down the message in a row of 8 columns. The coded
# message is then obtained by reading down the columns going left to right.
#
# For example, the message is "The quick brown fox jumps over the lazy dog".
#
# Then the message would be laid out as below:
#
#   thequick
#   brownfox
#   jumpsove
#   rthelazy
#   dog
#
# The code message would be as below:
#
#   tbjrd hruto eomhg qwpe unsl ifoa covz kxey
#
# Write a script that accepts a message from command line and prints the
# equivalent coded message.
# "
#
# My notes: sounds trivial, let's write the decoder as well.  Let's also
# make it easy to change the "8 columns", and let the user do encoding
# or decoding for any number of columns.
#

use feature 'say';
use strict;
use warnings;
use Function::Parameters;
#use Data::Dumper;

my $ncolumns = 8;


#
# my $encodedtext = encode($text);
#	Encode $text according to the above "Square Secret Code" rules.
#	Return the encoded text.
#
fun encode( $text )
{
	my @columns;
	$text =~ s/\s+//g;		# remove all whitespace
	my $len = length($text);
	foreach my $pos (0..$len-1)
	{
		my $ch = substr($text,$pos,1);
		$columns[$pos%$ncolumns] //= "";
		$columns[$pos%$ncolumns] .= $ch;
	}
	#die Dumper \@columns;
	my $result = join( ' ', @columns );
	return $result;
}


#
# my $decodedtext = decode($text);
#	Decode $text according to the above "Square Secret Code" rules.
#	Return the decoded text.
#
fun decode( $text )
{
	my @columns = split( /\s+/, $text );
	my $ncols = @columns;
	die "decode: $text has $ncols columns, not $ncolumns\n"
		unless $ncols == $ncolumns;
	my $npasses = length( $columns[0] );
	my $result = "";
	foreach my $p (1..$npasses)
	{
		foreach (@columns)
		{
			if( $_ )
			{
				s/(^\w)//;	# remove 1st char from column
				$result .= $1;
			}
		}
	}
	return $result;
}


die "Usage: ch-1.pl TEXT [0_for_decode,1_for_encode [ncolumns]]\n" if @ARGV<1 || @ARGV>3;
my $text = shift;
my $decode = shift // 0;
$ncolumns = shift // 8;

my $t;
if( $decode )
{
	$t = decode($text);
} else
{
	$t = encode($text);
}
say $t;

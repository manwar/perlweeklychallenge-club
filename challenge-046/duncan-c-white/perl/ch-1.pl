#!/usr/bin/perl
#
# 
# Task 1: "Cryptic Message:
# 
# The communication system of an office is broken and messages received
# are not completely reliable. If we sent the message Hello 6 times, it
# might end up sending these following corrupt messsages:
# 
# H x l 4 !
# c e - l o
# z e 6 l g
# H W l v R
# q 9 m # o
# 
# Similarly another day we received a message repeatedly like below:
# 
# P + 2 l ! a t o
# 1 e 8 0 R $ 4 u
# 5 - r ] + a > /
# P x w l b 3 k \
# 2 e 3 5 R 8 y u
# < ! r ^ ( ) k 0
# 
# Write a script to decrypt the above repeated message (one message repeated
# 6 times).
# 
# HINT: Look for characters repeated in a particular position in all six
# messages received.
# "
# 
# My notes: ah, so pick maxfreq letter in each column?
#  invoke as:
#   ./ch-1.pl 'Hxl4!' 'ce-lo' 'ze6lg' 'HWlvR' 'q9m#o'
#  result: Hello
#
#   ./ch-1.pl 'P+2l\!ato' '1e80R$4u' '5-r]+a>/' \
#	      'Pxwlb3k\' '2e35R8yu' '<\!r^()k0'
#  result: PerlRaku
# 

use feature 'say';
use strict;
use warnings;
use Data::Dumper;

die "Usage: mergemsg M1 M2 M3....\n" unless @ARGV>1;

my @freq;	# array of bags

foreach my $msg (@ARGV)
{
	my @letter = split( //, $msg );
	foreach my $i (0..$#letter)
	{
		$freq[$i] //= {};
		$freq[$i]{$letter[$i]}++;
	}
}

#die Dumper \@freq;

my $result = "";
foreach my $i (0..$#freq)
{
	my $max = -1;
	my $let = '';
	my $href = $freq[$i];
	while( my($l,$f) = each %$href )
	{
		if( $f > $max )
		{
			$max = $f;
			$let = $l;
		}
	}
	$result .= $let;
}
say $result;

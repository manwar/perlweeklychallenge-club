#!/usr/bin/perl
#
# Challenge 2: "Write a script to implement Lempel-Ziv-Welch (LZW)
# compression algorithm. The script should have method to encode/decode
# algorithm. The wiki page
# https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Welch
# explains the compression algorithm very nicely."
# 
# My notes: My code is in LZW.pm
# Ok, having written the encode/decode routines, let's give them a
# workout..
# 

use strict;
use warnings;
use Function::Parameters;

use lib qw(.);	# I hate this!
use LZW;

my @dict = ( 'A'..'Z' );

lzw_setdict( @dict );
lzw_setdebug( 0 );

#
# my $plain = make_random_string( $len );
#	Make a random string of length $len, using dictionary @dict.
#
fun make_random_string( $len )
{
	my $result = "";
	my $dictsize = @dict;
	foreach my $n (1..$len)
	{
		$result .= $dict[ int(rand($dictsize)) ];
	}
	return $result;
}


die "Usage: testlzw NSTRINGS LENGTH\n" unless @ARGV==2;
my $n = shift;
my $len = shift;

srand( $$ ^ time() );

foreach (1..$n)
{
	my $text = make_random_string( $len );
	my $binstr = lzw_encode( $text );
	$text .= '#';
	print "text: $text\n";
	#print "  encodes to: $binstr\n";
	my $text2 = lzw_decode( $binstr );
	#print "  which decodes to: $text2\n";
	#print "  encodes+decodes to: $text2\n";
	die "text $text -> encodes to $binstr -> decodes to $text2\n"
		unless $text eq $text2;
}

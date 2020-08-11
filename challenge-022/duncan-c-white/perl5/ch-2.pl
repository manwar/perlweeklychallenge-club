#!/usr/bin/perl
#
# Challenge 2: "Write a script to implement Lempel-Ziv-Welch (LZW)
# compression algorithm. The script should have method to encode/decode
# algorithm. The wiki page
# https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Welch
# explains the compression algorithm very nicely."
# 
# My notes: I read the wiki page, perhaps without concentrating enough.
# Looks complicated, especially the decoding part.  My code is in LZW.pm
# 

use strict;
use warnings;

use lib qw(.);	# I hate this!
use LZW;

my @dict = ( 'A'..'Z' );

lzw_setdict( @dict );
lzw_setdebug( 1 );

die "Usage: ch-2.pl E TEXT\nor   : ch-2.pl D binarystring\n" unless @ARGV==2;
my $op = shift;

die "ch-2.pl: bad encode/decode op $op\n" unless $op eq "E" || $op eq "D";

my $arg = shift;

#die "debug: np2(1023)==", np2(1023), "\nnp2(1024)==", np2(1024), "\nnp2(1025)==", np2(1025);

if( $op eq "E" )
{
	my $binstr = lzw_encode( $arg );
	print "$binstr\n";
}
elsif( $op eq "D" )
{
	my $text = lzw_decode( $arg );
	print "$text\n";
}

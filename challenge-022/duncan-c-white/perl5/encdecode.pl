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
# workout via encoding and then decoding a plain text string..
# 

use strict;
use warnings;
use Function::Parameters;

use lib qw(.);	# I hate this!
use LZW;

my @dict = ( 'A'..'Z' );

lzw_setdict( @dict );
lzw_setdebug( 0 );

die "Usage: encdecode STRING\n" unless @ARGV==1;
my $text = shift;

$text .= '#' unless substr($text,length($text)-1) eq '#';

my $binstr = lzw_encode( $text );
print "\ntext: $text\n" if 0;
#print "  encodes to: $binstr\n";
my $text2 = lzw_decode( $binstr );
#print "  which decodes to: $text2\n";
print "  encodes+decodes to: $text2\n" if 0;
die "text $text -> encodes to $binstr -> decodes to $text2\n"
	unless $text eq $text2;

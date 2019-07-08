#!/usr/bin/perl

# Challenge 2: "Write a script to implement the Vigenère cipher. The script
# should be able to encode and decode."
# 
# My notes:
# 
# Ok, pretty easy.

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;
use Getopt::Long;

my $territories = 0;
die "Usage: ch-2.pl [encrypt|decrypt] TEXT KEY\n" unless
	@ARGV == 3;

my $mode = shift;
my $text = shift;
my $key = shift;

#
# my $ciphertext = encrypt( $plaintext, $key );
#	Encrypt the $plaintext using the $key. Return the ciphertext.
#
fun encrypt( $plaintext, $key )
{
	my $a = ord('A');
	my $result = "";
	$key = uc($key);
	$plaintext = uc($plaintext);
	my @k = split(//, $key );
	my @runningkey = @k;
	foreach my $letter (split( //, $plaintext))
	{
		next unless $letter =~ /[A-Z]/;
		my $keyletter = shift @runningkey;
		push @runningkey, @k unless @runningkey;
		my $n = (ord($letter) - $a + ord($keyletter) - $a) % 26;
		$result .= chr($n+$a);
	}
	return $result;
}


#
# my $plaintext = decrypt( $cipherrtext, $key );
#	Decrypt the $ciphertext using the $key. Return the plain text.
#
fun decrypt( $ciphertext, $key )
{
	my $a = ord('A');
	my $result = "";
	$key = uc($key);
	$ciphertext = uc($ciphertext);
	my @k = split(//, $key );
	my @runningkey = @k;
	foreach my $letter (split( //, $ciphertext))
	{
		next unless $letter =~ /[A-Z]/;
		my $keyletter = shift @runningkey;
		push @runningkey, @k unless @runningkey;
		my $n = (ord($letter) - $a - (ord($keyletter) - $a)) % 26;
		$result .= chr($n+$a);
	}
	return $result;
}


my $out;
if( $mode =~ /^e/i )
{
	$out = encrypt( $text, $key );
} else
{
	$out = decrypt( $text, $key );
}

print "output $out\n";


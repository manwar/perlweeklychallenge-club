#!/usr/bin/perl
# 
# TASK #2 - Validate SEDOL
# 
# You are given 7-characters alphanumeric SEDOL.
# 
# Write a script to validate the given SEDOL. Print 1 if it is a valid SEDOL otherwise 0.
# 
# For more information about SEDOL, please checkout https://en.wikipedia.org/wiki/SEDOL
# 
# Example 1
# 
#   Input: $SEDOL = '2936921'
#   Output: 1
# 
# Example 2
# 
#   Input: $SEDOL = '1234567'
#   Output: 0
# 
# Example 3
# 
#   Input: $SEDOL = 'B0YBKL9'
#   Output: 1
# 
# MY NOTES: Pretty easy translation of the Javascript version in the SEDOL web page.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;

die "Usage: validate-sedol [-d|--debug] CODE\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $code = shift @ARGV;
my $l = length($code);

die "$code length $l, not 7\n" unless $l == 7;

 
my @weight = (1, 3, 1, 7, 3, 9, 1);


#
# my( $checkdigit, $errormessage ) = sedol_check_digit( $code );
#	Take a 6-char SEDOL code, and calculate and return the
#	7th digit (the check digit), or (undef, $errormessage) to
#	indicate an error.
#
fun sedol_check_digit( $code )
{

    unless( $code =~ /^[0-9BCDFGHJ-NP-TV-Z]{6}$/ )
    {
	 return (undef, "Invalid SEDOL number '$code'");
    }
    my $sum = 0;
    my $l = length($code);
    $code = lc($code);
    for( my $i = 0; $i < $l; $i++)
    {
        my $char = substr($code,$i,1);
	my $base36 = ($char =~ /^\d/) ? ord($char)-ord('0') : ord($char)+10-ord('a');
	say "debug: code=$code, char=$char, base36=$base36, i=$i, w[i]==$weight[$i]" if $debug;
	$sum += $weight[$i] * $base36;
    }
    my $check = (10 - $sum%10) % 10;
    return ($check, undef);
}


#
# my $validsedol = checkSedol( $text );
#	Return 1 iff $text is a valid Sedol code; 0 otherwise.
#
fun checkSedol( $text )
{
	my $input = substr($text,0,6);
	my( $checkdigit, $error ) = sedol_check_digit($input);
	return 0 if defined $error;
	say "debug: checkSedol($text): checkdigit = $checkdigit" if $debug;
	return $text eq $input . $checkdigit;
}


my $validsedol = checkSedol( $code );
say $validsedol ? 1 : 0;

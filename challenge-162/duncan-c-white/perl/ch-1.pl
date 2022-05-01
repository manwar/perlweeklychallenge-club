#!/usr/bin/perl
# 
# TASK #1 - ISBN-13
# 
# Write a script to generate the check digit of given ISBN-13 code. Please
# refer to
# 
# https://en.wikipedia.org/wiki/ISBN#ISBN-13_check_digit_calculation
# 
# for more information.  In summary, take each of the first 12 digits of
# an ISBN code, from left to right, multiple 1st, 3rd, 5th etc by 1, and
# the 2nd, 4th, 6th etc by 3, sum the result.  Mod 10 the sum.  Subtract
# the sum from 10.  Mod 10 the result.
# 
# Example
# 
# ISBN-13 check digit for '978-0-306-40615-7' is 7.
# 
# MY NOTES: ok.  Pretty easy.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl into C,
# look in the C directory for that.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(sum0);

my $debug=0;
die "Usage: isbn-13-checker [--debug] isbn-number\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $isbn = shift;
$isbn =~ tr/-//d;
my $len = length($isbn);
if( $len==13 )
{
	$isbn =~ s/.$//;
	$len--;
}

die "isbn-13 checker: $isbn (len $len) should be 12 chars long\n"
	unless $len == 12;

my $scale = 3;
my $total = sum0( map { $scale = 4-$scale; $scale * $_; } split(//,$isbn) );
$total %= 10;
$total = 10-$total;
$total %= 10;

say $total;

#!/usr/bin/perl
# 
# TASK #1 - Fibonacci Words
# 
# You are given two strings having same number of digits, $a and $b.
# 
# Write a script to generate Fibonacci Words by concatenation of the
# previous two strings. Finally print 51st digit of the first term having
# at least 51 digits.
# 
# Example:
# 
#     Input: $a = '1234' $b = '5678'
#     Output: 7
# 
#     Fibonacci Words:
# 
#     '1234'
#     '5678'
#     '12345678'
#     '567812345678'
#     '12345678567812345678'
#     '56781234567812345678567812345678'
#     '1234567856781234567856781234567812345678567812345678'
# 
#     The 51st digit in the first term having at least 51 digits
#     '1234567856781234567856781234567812345678567812345678' is 7.
# 
# MY NOTES: Pretty easy.  Fibonacci words == append two previous strings.
#	Use -d (debug mode) to see all the above explanatory info.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(sum);

my $debug=0;
die "Usage: fib-words [--debug] A B\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;
my( $a, $b ) = @ARGV;

my @out = "Fibonacci words\n\'$a'\n'$b'";

for(;;)
{
	# form next Fibonacci word
	my $next = $a.$b;
last if length($b) > 50;
	push @out, "'$next'";
	$a = $b;
	$b = $next;
}

my $digit51 = substr($b,50,1);
push @out, "\nThe 51st digit in the first term having at least 51 digits";
push @out, "'$b', is $digit51";

say "Output: $digit51";

if( $debug )
{
	say "";
	say for @out;
}

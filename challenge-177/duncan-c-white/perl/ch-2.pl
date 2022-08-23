#!/usr/bin/perl
# 
# Task 2: Palindromic Prime Cyclops
# 
# Write a script to generate first 20 Palindromic Prime Cyclops Numbers.
# 
# A cyclops number is a number with an odd number of digits that has a
# zero in the center only.
# 
# Output
# 
# 101, 16061, 31013, 35053, 38083, 73037, 74047, 91019, 94049,
# 1120211, 1150511, 1160611, 1180811, 1190911, 1250521, 1280821,
# 1360631, 1390931, 1490941, 1520251
# 
# 
# MY NOTES: This seems pretty easy.  Find numbers that are
# a). cyclops numbers and
# b). prime numbers and
# c). palindromic numbers
# (although, as the late great Eric Morecambe would say: but not
# necessarily in that order).
# 
# - Obvious way to generate palindromic cyclops numbers is to append
#   x + 0 + rev(x)
#   for each small integer x = 1, 2...
# - and then test each such number for primality
# - extracted isprime() function from my solution to challenge 156 task 1,
#   and put it in it's own IsPrime module.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

use lib qw(.);
use IsPrime;


my $debug=0;
die "Usage: first-N-palindomic-prime-cyclops-numbers [--debug] [N default 20]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;

my $n = shift // 20;

my @results = ();
for( my $x=1; @results < $n; $x++ )
{
	next if $x =~ /0/;
	my $num = $x . '0'. reverse($x);
	say "debug: x=$x, num=$num" if $debug;
	push @results, $num if isprime($num);
}

# format the results with lines <= maxw chars long.
my $maxw = 65;
my $str = join( ', ', @results );
while( length($str) >= $maxw )
{
	my $pos;
	for( $pos=$maxw; $pos>0 && substr($str,$pos,1) ne ' '; $pos-- )
	{
	}
	say substr($str,0,$pos);
	$str = substr($str,$pos+1);
}
say $str;

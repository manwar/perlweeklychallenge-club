#!/usr/bin/perl
# 
# TASK #2 - Cardano Triplets
# 
# Write a script to generate first N Cardano Triplets.
# 
# MY NOTES: This version (ch-2FAST.pl) uses a much more efficient parameterised
# version of Cardano Triplets that I found on the Internet but frankly don't
# understand how it was derived. See
#
# https://math.stackexchange.com/questions/1885095/parametrization-of-cardano-triplet
#
# Specifically the author of that question claimed that the Cardano triplets
# formula may be expanded to:
#       8a**3+15a**2+6a - 27x=1
# where a=3k+2 and
#       x=(k+1)**2(8k+5)
#	(x represents b*b*c)
# 
# If this is correct, we can just loop directly through k calculating each
# (a, x), and selecting those for which the 8a**3... formula succeeds.
# Then we need to break x down into b and c - noting that several (b,c)
# pairs may result from a single value of x, so this doesn't generate
# Cardano triplets in anything like the same order as ch-2.pl does.
#
# Also, we may need bignum as the numbers get pretty big..
#
# In fact, I now realise that each (a,x) pair for every k automatically
# satisfies the 8a**3... formula so we don't even need to check it:
# this is now only checked if you specific --paranoid when running this.
#
# How much faster is this than ch-2.pl?  For n=40, ch-2.pl takes 30 seconds
# where this (ch-2FAST.pl) takes just under 2 seconds!  And this gets better
# as n increases: this version takes 6.9s for n=100, but I gave up on
# running ch-2.pl 40 after a couple of minutes when it had only found about
# 60 triples..  of course this version is faster, we are directly finding
# the (a,x) partial solutions and only have to break x down to one or more
# (b,c) pairs, whereas ch-2.pl is basically a brute force search.
# 

use strict;
use warnings;
use bignum;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
my $paranoid=0;

die "Usage: first-N-cardano-triplets [--debug] [--paranoid] [N default 5]\n"
	unless GetOptions( "debug"=>\$debug, "paranoid"=>\$paranoid )
	&&     @ARGV<2;

my $n = shift // 5;

my $nfound = 0;

for( my $k=0; $nfound < $n; $k++ )
{
	my $a = 3*$k + 2;
	my $x = ($k+1)**2 * (8*$k+5);
	say "k=$k, a=$a, x=$x" if $debug;
	if( $paranoid )
	{
		my $lhs = 8*$a**3+15*$a**2+6*$a - 27*$x;
		#say "k=$k, a=$a, lhs=$lhs" if $debug;
		die "Parameterisation error for k=$k, a=$a, x=$x, lhs=$lhs ".
		    "(lhs is not 1)\n" unless $lhs==1;
	}

	# ok, now we need to find possible (b,c) values such that
	# b*b*c == x; note that there can be several for a single x!
	say "k=$k matches.. breakdown $x" if $debug;
	my $lim = int(sqrt($x));
	for( my $b=1; $b<=$lim; $b++ )
	{
		my $c = int( $x / ($b*$b) );
		next unless $b*$b*$c == $x;
		$nfound++;
		say "Found $a,$b,$c" if $nfound<=$n;
	}
}

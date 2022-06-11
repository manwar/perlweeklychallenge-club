#!/usr/bin/perl
# 
# TASK #1 - Sum Bitwise Operator
# 
# ch-1a.pl: a slightly different approach.  We didn't need to build the
# list of all the pairs, we could merge the two passes into one
# easily enough, as shown here:
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: sum-bitwise-pairs [--debug] list of numbers\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>1;
my @v = @ARGV;

my $lastpos = $#v;
my $sum = 0;
foreach my $i (0..$lastpos-1)
{
	foreach my $j ($i+1..$lastpos)
	{
		my $a = $v[$i];
		my $b = $v[$j];
		my $r = $a & $b;
		say "debug: i=$i, j=$j, a=$a, b=$b, a&b=$r" if $debug;
		$sum += $r;
	}
}
say $sum;

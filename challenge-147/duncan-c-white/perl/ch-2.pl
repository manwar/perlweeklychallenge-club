#!/usr/bin/perl
# 
# TASK #2 - Pentagon Numbers
# 
# Write a script to find the first pair of Pentagon Numbers whose sum
# and difference are also a Pentagon Number.
# 
#     Pentagon numbers can be defined as P(n) = n(3n - 1)/2.
# 
# Example
# 
# 	The first 10 Pentagon Numbers are:
# 	1, 5, 12, 22, 35, 51, 70, 92, 117 and 145.
# 
# 	P(4) + P(7) = 22 + 70 = 92 = P(8)
# 	but
# 	P(4) - P(7) = |22 - 70| = 48 is not a Pentagon Number.
# 
# MY NOTES: Ok, reasonably straight forward, calc first N Pentagon numbers,
# form a sethash of them to allow lookups, then iterate over all pairs of
# Pentagon numbers rejecting all pairs where the diff or sum isn't a Pentagon
# number. The diff of any two of the first N Pentagon numbers is obviously
# smaller, so may be looked up directly in the sethash.  The only tricky bit
# concerns the SUM of any two of them, because that sum may be greater than
# the biggest Pentagon number we know as yet, hence not in the sethash because
# we haven't calculated such Pentagon numbers yet - not because it's not a
# Pentagon number.  I can nearly see the structure of an adaptive solution,
# that generates Pentagon numbers incrementally, but it's a bit tricky.
# So instead let's Keep It Simple - just generate the first N Pentagon numbers
# and see if we can find any matching pair of those (where the sum is in the
# first N Pentagon numbers).  If not, run the program again with a bigger value
# of N.  Experimentation reveals that N=2400 finds the solution..
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


my $debug=0;

die "Usage: first-pentagon-number-pair [--debug] NP\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV<2;

my $np = shift // 2400;
my @p = map { $_ * (3*$_-1) / 2 } 1..$np;

#die Dumper(\@p);

my %isp = map { $_ => 1 } @p;
#die Dumper(\%isp);

# try all pairs where first>second (so that the diff doesn't need abs())..

foreach my $fpos (0..$#p)
{
	my $first = $p[$fpos];
	foreach my $spos (0..$fpos-1)
	{
		my $second = $p[$spos];
		die if $first <= $second;
		say "trying $first, $second" if $debug;
		my $diff = $first-$second;
		next unless $isp{$diff};
		my $sum = $first+$second;
		next unless $isp{$sum};
		say "found pair P[$fpos], P[$spos]: $first, $second: sum=$sum, diff=$diff";
		exit 0;
	}
}

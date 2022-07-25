#!/usr/bin/perl
# 
# Task 2: Permutation Ranking
# 
# You are given a list of integers with no duplicates, e.g. [0, 1, 2].
# 
# Write two functions, permutation2rank() which will take the list and
# determine its rank (starting at 0) in the set of possible permutations
# arranged in lexicographic order, and rank2permutation() which will take
# the list and a rank number and produce just that permutation.
# 
# Please checkout this post for more informations and algorithm:
#   https://tryalgo.org/en/permutations/2016/09/05/permutation-rank/
# 
# Given the list [0, 1, 2] the ordered permutations are:
# 
# 0: [0, 1, 2]
# 1: [0, 2, 1]
# 2: [1, 0, 2]
# 3: [1, 2, 0]
# 4: [2, 0, 1]
# 5: [2, 1, 0]
# 
# and therefore:
# 
# permutation2rank([1, 0, 2]) = 2
# 
# rank2permutation([0, 1, 2], 1) = [0, 2, 1]
# 
# MY NOTES: hmm.. I hate permutations, never managed to memorise the
# algorithm in all my years of programming.  However, I've got a module
# Perm.pm which does this, so let's reuse it to do the simplest possible
# version of this without really thinking over-hard.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

use lib qw(.);
use Perms;

my $debug=0;
die "Usage: permute-stuff [--debug] string-of-digits (p2r | r2p R)\n"
	unless GetOptions( "debug"=>\$debug ) && (@ARGV==2 || @ARGV==3);

my $list = shift;
my $cmd = shift;
die "permute-stuff: bad command $cmd (should be p2r or r2p)\n"
	unless $cmd eq "p2r" || $cmd eq "r2p";
my @list = split( //, $list );
my $perm = join( '', sort { $a <=> $b } @list );

if( $cmd eq "p2r" )	# permutation to rank
{
	my $rank;
	for( $rank=0; $list ne $perm; $rank++ )
	{
		$perm = Perms::next_perm( $perm );
	}
	say "p2r($list) = $rank";
} else
{
	die "permute-stuff: r2p needs to be followed by a rank no\n"
		if @ARGV==0;
	my $rank = shift;
	for( my $i=0; $i != $rank; $i++ )
	{
		$perm = Perms::next_perm( $perm );
	}
	say "r2p( $list, $rank ) = $perm";
}

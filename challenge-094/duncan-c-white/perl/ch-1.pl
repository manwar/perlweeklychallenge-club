#!/usr/bin/perl
#
# Task 1: "Group Anagrams
# 
# You are given an array of strings @S.
# 
# Write a script to group sets of Anagrams (containing the same letters), the order of the anagram-sets doesn't matter.
# 
# An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.
# 
# Example 1:
# 
#     Input: ("opt", "bat", "saw", "tab", "pot", "top", "was")
#     Output: [ ("bat", "tab"),
#               ("saw", "was"),
#               ("top", "pot", "opt") ]
# 
# Example 2:
# 
#     Input: ("x")
#     Output: [ ("x") ]
# "
# 
# My notes: yippee!  Good old "Programming Pearls" by Jon Bentley tackled a
# very similar problem, using SIGNATURES (the sorted bag of letters contained
# in a word) - all anagrams with the same signature by definition form part
# of the same anagram group.  Time for a Perfect Data Structure:
# 
# "this problem would be trivial if only we could build a data structure
# mapping from a signature to a list of all the words with that signature".
# 
# Ok, let's build that then: a HoA.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug = 0;
die "Usage: anagram-groups [--debug] W1 W2...Wn\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV>1;
my @w = @ARGV;

my %perfect;	# hash from signature to an array ref - words with that signature
foreach my $w (@w)
{
	# signature = sorted letters in $w
	my $sig = join('', sort split( //, $w ));

	say "$w $sig" if $debug;

	my $aref = ($perfect{$sig} //= []);

	# add word to perfect{sig}
	push @$aref, $w;
}

# dispose of signatures (no longer need the keys - unusual)
my @v = values %perfect;

# each element of @v is an arrayref of words: print each word comma-separated
say join(',',@$_) for @v;

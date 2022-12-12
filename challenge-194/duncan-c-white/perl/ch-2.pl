#!/usr/bin/perl
# 
# Task 2: Frequency Equalizer
# 
# You are given a string made of alphabetic characters only, a-z.
# 
# Write a script to determine whether removing only one character can make
# the frequency of the remaining characters the same.
# 
# Example 1:
# 
# Input: $s = 'abbc'
# Output: 1 since removing one alphabet 'b' will give us 'abc' where each alphabet frequency is the same.
# 
# Example 2:
# 
# Input: $s = 'xyzyyxz'
# Output: 1 since removing 'y' will give us 'xzyyxz'.
# 
# Example 3:
# 
# Input: $s = 'xzxz'
# Output: 0 since removing any one alphabet would not give us string with same frequency alphabet.
# 
# MY NOTES: sounds pretty easy.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;


my $debug=0;
die "Usage: freq-eq [--debug] string\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $str = shift;

my @let = split( //, $str );

# build the frequency hash
my %freq;
foreach my $l (@let)
{
	$freq{$l}++;
}

# sort the frequency hash
my @sortf = map { $freq{$_} } sort { $freq{$a} <=> $freq{$b} } keys %freq;

say "sorted freqs are: ", join(',', @sortf ) if $debug;

=pod

=head2 my $ok = can_eq( @sortedfreqs );

Given a sorted array of letter frequencies,
remove 1 iff the biggest frequency is 1+the 2nd biggest freq
and the smallest freq is the same as the 2nd biggest freq;
return 0 otherwise.

=cut
fun can_eq( @sf )
{
	my $lastf = $#sf;
	return 1 if $sf[$lastf] == 1 + $sf[$lastf-1] &&
		    $sf[0] == $sf[$lastf-1];
	return 0;
}


say can_eq(@sortf);

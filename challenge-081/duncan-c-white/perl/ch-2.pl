#!/usr/bin/perl
#
# Task 2: "Frequency Sort
# 
# You are given file named input.
# 
# Write a script to find the frequency of all the words.
# 
# It should print the result as first column of each line should be the
# frequency of the the word followed by all the words of that frequency
# arranged in lexicographical order. Also sort the words in the ascending
# order of frequency.
# 
# INPUT file
# 
# West Side Story
# 
# The award-winning adaptation of the classic romantic tragedy "Romeo and
# Juliet". The feuding families become two warring New York City gangs,
# the white Jets led by Riff and the Latino Sharks, led by Bernardo. Their
# hatred escalates to a point where neither can coexist with any form
# of understanding. But when Riff's best friend (and former Jet) Tony
# and Bernardo's younger sister Maria meet at a dance, no one can do
# anything to stop their love. Maria and Tony begin meeting in secret,
# planning to run away. Then the Sharks and Jets plan a rumble under the
# highway--whoever wins gains control of the streets. Maria sends Tony
# to stop it, hoping it can end the violence. It goes terribly wrong,
# and before the lovers know what's happened, tragedy strikes and doesn't
# stop until the climactic and heartbreaking ending.
# 
# NOTE
# 
# For the sake of this task, please ignore the following in the input file:
# 
# . " ( ) , 's --
# 
# OUTPUT
# 
# 1 But City It Jet Juliet Latino New Romeo Side Story Their Then West York
# adaptation any anything at award-winning away become before begin best
# classic climactic coexist control dance do doesn't end ending escalates
# families feuding form former friend gains gangs goes happened hatred
# heartbreaking highway hoping in know love lovers meet meeting neither no
# one plan planning point romantic rumble run secret sends sister streets
# strikes terribly their two under understanding until violence warring
# what when where white whoever wins with wrong younger
# 
# 2 Bernardo Jets Riff Sharks The by it led tragedy
# 
# 3 Maria Tony a can of stop
# 
# 4 to
# 
# 9 and the
# "
# 
# My notes: classic.  data structure is freq -> list of words of that frequency.
#

use strict;
use warnings;
use feature 'say';
use Data::Dumper;

die "Usage: frequency-sort filename\n" unless @ARGV==1;
my $filename = shift;

my %freq;
open( my $infh, '<', $filename ) || die;
while( <$infh> )
{
	chomp;
	# ignore: . " ( ) , 's --
	tr/."(),//d;
	s/'s//g;
	s/--/ /g;
	#say;
	my @wd = split( /\s+/, $_ );
	$freq{$_}++ for @wd;
}
close($infh);

#say Dumper \%freq;

# build main data structure: array of freq -> list of words

my @fw;
foreach my $wd (sort keys %freq)
{
	my $f = $freq{$wd};
	$fw[$f] //= [];
	push @{$fw[$f]}, $wd;
}

#say Dumper \@fw;

# Display the desired output

foreach my $f (0..$#fw)
{
	next unless defined $fw[$f];
	my @w = @{$fw[$f]};
	say "\n$f ", join(' ',@w);
}

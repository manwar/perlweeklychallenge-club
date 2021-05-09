#!/usr/bin/perl
# 
# Task 2: "Ordered Letters
#
# Given a word, you can sort its letters alphabetically (case
# insensitive). For example, "beekeeper" becomes "beeeeekpr" and
# "dictionary" becomes "acdiinorty".
# 
# Write a script to find the longest English words that don't change when
# their letters are sorted.
# "
# 
# My notes: nice!
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Text::CSV;
#use Data::Dumper;


my $wordfile = "/usr/share/dict/words";
die "Usage: longest-sort-letters [wordfile]\n" if @ARGV>1;
$wordfile = shift if @ARGV==1;

my $longest = "NO SUCH WORD";
my $longlen = -1;

open( my $infh, '<', $wordfile ) || die "can't open $wordfile\n";
while( <$infh> )
{
	chomp;
	my $sig = join( '', sort split(//,$_) );
	next unless $sig eq $_;
	my $l = length($sig);
	if( $l > $longlen )
	{
		$longlen = $l;
		$longest = $_;
	}
}
close( $infh );

print "longest word same as it's signature: $longest\n";

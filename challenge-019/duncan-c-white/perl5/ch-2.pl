#!/usr/bin/perl
#
# Challenge 2: "Write a script that can wrap the given paragraph at a specified
# column using the greedy algorithm."
# 
# My notes: Another clearly described problem.  Greedy algorithm wiki page
# just neans: fit words on the line while they fit:-)
# 

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

die "Usage: ch-2.pl width sentence\n" if @ARGV<2;
my $linelen = shift;
my $sentence = join( ' ', @ARGV );

my @words = split(/\s+/,$sentence);
my $line = shift @words;
my $linew = length($line);

foreach my $word (@words)
{
	my $len = length($word);
	if( $linew + $len + 1 < $linelen )
	{
		$line .= " $word";
		$linew += $len+1;
	} else
	{
		print "$line\n";
		$line = $word;
		$linew = $len;
	}
}
print "$line\n" if $line;

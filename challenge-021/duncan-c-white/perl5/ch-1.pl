#!/usr/bin/perl
#
# Challenge 1: "Write a script to calculate the value of e, also known
#  as Euler's number and Napier's constant."
# 
# My notes: The associated wiki page reminds us that the easiest way of
#   calculating e (the base of natural logarithms) is via:
#   e = 1 + 1/1! + 1/2! + 1/3! + 1/4! + ... 1/n!  Let's use that.
# 

use strict;
use warnings;
#use Function::Parameters;
#use Data::Dumper;

die "Usage: ch-1.pl [NUMTERMS]\n" if @ARGV>1;
my $nterms = shift // 30;

my $e = 0;
my $nfact = 1;
foreach my $n (1..$nterms)
{
	$e += 1/$nfact;
	$nfact *= $n;
}
print "e=$e\n";

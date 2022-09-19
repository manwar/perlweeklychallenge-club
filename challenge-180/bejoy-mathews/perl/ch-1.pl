#!/usr/bin/perl

use strict;
use warnings;

my $s = "Perl Weekly Challenge";
my @pwc = split('', $s);
my $pos=-1;

foreach(@pwc)
{
 $pos++;
 if (grep(/$pwc[$pos]/, @pwc[$pos..@pwc-1]) == 1) { print "The first unique character in '$s' is '$pwc[$pos]'\n"; exit }
}

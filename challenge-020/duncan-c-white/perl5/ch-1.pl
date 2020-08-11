#!/usr/bin/perl
#
# 
# Challenge 1: "Write a script to accept a string from command line and
# split it on change of character. For example, if the string is "ABBCDEEF",
# then it should split like 'A', 'BB', 'C', 'D', 'EE', 'F'."
# 
# My notes: Clearly defined, sounds like a job for regexes.
# 

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

die "Usage: ch-1.pl STRING\n" unless @ARGV==1;
my $str = shift;

# At first, I wrote:
# while( $str =~ s/^(A+|B+|C+|D+|E+|F+|G+|H+|I+|J+|K+|L+|M+|N+|O+|P+|Q+|R+|S+|T+|U+|V+|W+|X+|Y+|Z+)//i )
# but then I realised that the following much shorter regex would work:
while( $str =~ s/^(([A-Za-z])\2*)// )
{
	print "split: $1\n";
}

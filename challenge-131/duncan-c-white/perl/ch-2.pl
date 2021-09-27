#!/usr/bin/perl
# 
# Task 2: "Find Pairs
# 
# You are given a string of delimiter pairs and a string to search.
# 
# Write a script to return two strings, the first with any characters
# matching the 'opening character' set, the second with any matching
# the 'closing character' set.
# 
# Example 1:
# 
# Input:
#     Delimiter pairs: ""[]()
#     Search String: "I like (parens) and the Apple ][+" they said.
# 
# Output:
#     "(["
#     ")]"
# 
# Example 2:
# 
# Input:
#     Delimiter pairs: **//<>
#     Search String: /* This is a comment (in some languages) */ <could be a tag>
# 
# Output:
#     /**/<
#     /**/>
# "
# 
# My notes: also pretty easy, if I've understood it right.  Also should be
# doable in 1-pass.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;

die "Usage: find-pairs [-d|--debug] listofpairs searchstring\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;
my $pairlist = shift;
my $searchstring = shift;

my $len = length($pairlist);
die "find-pairs: listofpairs $pairlist must have EVEN length (not $len)"
	unless $len % 2 == 0;

my %open = 
	map { substr($pairlist,$_,1) => 1 }
	grep { $_ % 2 == 0 } 0..$len-1;

my %close =
	map { substr($pairlist,$_,1) => 1 }
	grep { $_ % 2 == 1 } 0..$len-1;

#say "open=".Dumper(\%open).", close=".Dumper(\%close) if $debug;

my $first = my $second = '';
foreach my $letter (split(//,$searchstring))
{
	$first .= $letter if $open{$letter};
	$second .= $letter if $close{$letter};
}

say "$first\n$second";

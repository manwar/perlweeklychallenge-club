#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

#usage 'perl script 1,2,10,3'

my @list = sort {$a <=> $b} split( /,/, join(',',@ARGV) );

my %lookup = map { $_ => undef } @list;

say "the range is 0..$list[-1]";
print "the missing number(s) are/is ";

for(0..$list[-1]){
	unless ( exists $lookup{ $_ }) {
           print "$_ "}
}

say "";


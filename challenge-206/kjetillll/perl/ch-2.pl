#!/usr/bin/perl
use warnings; use strict; use List::Util 'sum';

my @array = @ARGV;                 #use input from command line args
@array = (1,2,3,4) if not @array;  #...or use test case
#@array = (0,2,1,3) if not @array; #...or use test case

print "Input: @array\n";
print "Max sum: ", maxminsum(@array), "\n";

sub maxminsum { sum( (sort{$a<=>$b}@_)[map 2*$_,0..$#_/2] ) }

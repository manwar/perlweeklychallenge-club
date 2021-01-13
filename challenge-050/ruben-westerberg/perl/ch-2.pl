#!/usr/bin/env perl
#noble integers
use warnings;
use strict;

my $size=$ARGV[0]//3;
my @list= sort {$a > $b} map {int rand 50} 1..$size; 
#@list=sort { $a > $b} (2,1,6,3);
print "Sorted Input list: ",
join(",", @list),"\n";
print "Noble Integers found: ", join ", ", @list[grep { @list-$_-1 == $list[$_] } 0..@list-1];

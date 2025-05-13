#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#the basic idea is : sort the numbers and then pair the smallest with the largest,
#the second smallest with the second largest and so on. Count the number of 
#different averages!

say "Enter an even number of numbers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @sorted = sort { $a <=> $b } @numbers ;
my %averages ;
my $len = scalar( @sorted ) ;
for my $i (0.. $len / 2 - 1 ) {
   my $average = ($sorted[ $i ] + $sorted[ $len - $i - 1 ]) / 2 ;
   $averages{$average}++ ;
}
say scalar( keys %averages ) ;

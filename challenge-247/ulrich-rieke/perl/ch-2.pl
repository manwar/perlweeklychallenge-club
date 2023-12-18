#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string consisting of lowercase letters only!" ;
my $line = <STDIN> ;
chomp $line ;
my $len = length $line ;
my %frequencies ;
for my $pos ( 0..$len - 2 ) {
   $frequencies{ substr( $line, $pos , 2 ) }++ ;
}
my @sorted = sort { $frequencies{$b} <=> $frequencies{$a} || 
   $a cmp $b } keys %frequencies ;
say $sorted[0] ;   

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter an income!" ;
my $income = <STDIN> ;
chomp $income ;
say "Enter [a,b] [c,d] and so on as a number of taxrates!" ;
my $taxline = <STDIN> ;
chomp $taxline ;
my @pairs ; #this is denoted @tax in the task
my @brackets = split( /\s/ , $taxline ) ;
for my $br ( @brackets ) {
   if ( $br =~ /^\[(\d+)\s*,\s*(\d+)\]$/ ) {
      my ( $number , $tax ) = ( $1 , $2 ) ;
      push( @pairs , [$number , $tax] ) ;
   }
}
my @differences ; #differences between first elements of neighbouring pairs
#in @pairs 
push( @differences , $pairs[0]->[0] ) ;
for my $i ( 1..scalar( @pairs ) - 1 ) {
   push( @differences , $pairs[$i]->[0] - $pairs[$i - 1]->[0] ) ;
}
my @taxparts ; #how many elements of $income fall into each category of @pairs?
my $sum = 0 ;#sum up the elements of @differences until the sum is at least 
#equal to $income
my $index = 0 ;
while ( $sum < $income ) {
   push( @taxparts , $differences[ $index ] ) ;
   $sum += $differences[ $index ] ;
   $index++ ;
}
if ( $sum > $income ) {
   my $last = pop @taxparts ;
   push( @taxparts , $last - ( $sum - $income ) ) ;
}
my $totaltax = 0 ;
for my $i (0..scalar( @taxparts ) - 1 ) {
   $totaltax += $taxparts[ $i ] * $pairs[$i]->[1] / 100 ;
}
say $totaltax ;

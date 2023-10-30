#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my $max_greatness = 0 ;
my $iter = permutations( \@numbers ) ;
while ( my $p = $iter->next ) {
   my $current_greatness = 0 ;
   for my $i ( 0..$len - 1 ) {
      if ( $p->[ $i ] > $numbers[ $i ] ) {
	 $current_greatness++ ;
      }
   }
   if ( $current_greatness > $max_greatness ) {
      $max_greatness = $current_greatness ;
   }
}
say $max_greatness ;

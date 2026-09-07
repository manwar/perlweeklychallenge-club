#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all uniq zip) ;
use Algorithm::Combinatorics qw ( permutations ) ;

say "Enter a number!" ;
my $number = <STDIN> ;
chomp $number ;
if ( $number == 1 ) {
   say 0 ;
}
if ( $number == 2 ) {
   say 1 ;
}
if ( $number > 2 ) {
   my $original = [1..$number] ;
   my @entered = (1..$number) ;
   my $iter = permutations( \@entered ) ;
   my @possible_combis ;
   while ( my $p = $iter->next ) {
      my @result = zip $original , $p ;
      if ( all { $_->[0] != $_->[1] } @result ) {
         push( @possible_combis , \@result ) ;
      }
   }
   my @subset = uniq @possible_combis ;
   say scalar( @subset ) ;
}

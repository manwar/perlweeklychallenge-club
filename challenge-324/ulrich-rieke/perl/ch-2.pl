#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( subsets ) ;
use List::Util qw ( sum ) ;

#the task is equivalent to finding the sum of all pairwise application of
#xor in all subsets in the powerset of the array that was passed
#all the sums of the subsets are then summed up

sub mySum {
   my $array = shift ;
   my $sum = 0 ;
   for my $elt ( @$array ) {
      $sum ^= $elt ;
   }
   return $sum ;
}

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $iter = subsets( \@numbers ) ;
my @subsums ;
while ( my $p = $iter->next( ) ) {
   push( @subsums , mySum( $p ) ) ;
}
say sum( @subsums ) ;

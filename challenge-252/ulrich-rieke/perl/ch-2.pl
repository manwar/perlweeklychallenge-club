#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

say "Enter a positive integer!" ;
my $number = <STDIN> ;
chomp $number ;
my @solution ;
my $limit = int( $number / 2 ) ;
my $neg_limit = -$limit ;
if ( $number % 2 == 1 ) {
   for my $num ( $neg_limit..$limit ) {
      push @solution, $num ;
   }
}
else {
   my $current = $neg_limit ;
   for (1..$number - 1 ) {
      push @solution, $current ;
      $current++ ;
   }
   my $sum = sum( @solution ) ;
   push @solution, 0 - $sum ;
}
say "(" . join( ',' , @solution ) . ")" ;



#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( variations_with_repetition ) ;
use List::Util qw ( sum ) ;
use POSIX qw ( floor ) ;

my $S = $ARGV[ 0 ] ;
my @basketballPoints = ( 1 , 2 , 3 ) ;
my @allCombis ;
my $maxtimes = $S ; #we can gather that many 1's from @basketballPoints
my $mintimes ; #the minimum number of 3 to arrive at $S points
if ( $S % 3 == 0 ) {
  $mintimes = $S / 3 ;
}
else {
  $mintimes = floor( $S / 3 ) + 1 ;
}
my $i = $maxtimes ;
while ( $i > $mintimes - 1 ) {
  my $iter = variations_with_repetition(\@basketballPoints , $i ) ;
  while ( my $c = $iter->next ) {
      if ( sum( @$c ) == $S ) {
    push @allCombis , $c ;
      }
  }
  $i-- ;
}
for my $sequence( @allCombis ) {
  say join( ' ' , @$sequence ) ;
}

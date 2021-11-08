#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my $N = $ARGV[ 0 ] ;
my %triples ;
for my $i (1 .. 100 ) {
  for my $j (1 .. 100 ) {
      for my $k (1 .. 100 ) {
    if ( ($i ** 2) + ( $j ** 2 ) == $k ** 2 ) {
        if ( ($i == $N) or ( $j == $N ) or ( $k == $N )) {
          my @sorted = sort { $a <=> $b } ( $i , $j , $k ) ;
          $triples{join( ', ' ,  @sorted)}++ ;
        }
    }
      }
  }
}
if ( keys %triples ) {
  map { say '(' . $_ . ')' } keys %triples ;
}
else {
  say -1 ;
}

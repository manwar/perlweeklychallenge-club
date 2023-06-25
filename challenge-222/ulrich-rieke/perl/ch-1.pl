#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split ( /\s/ , $line ) ;
my @sorted = sort { $a <=> $b } @numbers ;
my $samepos = 0 ;
for my $i ( 0 .. scalar( @numbers ) - 1 ) {
  if ( $sorted[ $i ] == $numbers[ $i ] ) {
      $samepos++ ;
  }
}
say $samepos ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, at most one missing and one duplicate, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @sorted = sort { $a <=> $b } @numbers ;
my $len = scalar( @sorted ) ;
my @found ;
for my $i ( 0..$len - 2 ) {
  if ( $sorted[ $i + 1 ] == $sorted[ $i ] ) { #duplicate
      push @found , $sorted[ $i ] ;
      if ( $i == $len - 2 ) { #duplicate at the end also means missing
    push @found, $sorted[ $i ] + 1 ;
      }
  }
  if ( $sorted[ $i + 1 ] - $sorted[ $i ] > 1 ) { #missing
      push @found , $sorted[ $i ] + 1 ;
  }
}
if ( @found ) {
  print "(" ;
  print join( ',' , @found ) ;
  say ")" ;
}
else {
  say "-1" ;
}

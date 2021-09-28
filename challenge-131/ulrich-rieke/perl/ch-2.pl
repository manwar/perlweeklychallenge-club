#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter delimiters!" ;
my $delimiters = <STDIN> ;
chomp $delimiters ;
say "Enter search string!" ;
my $searchstring = <STDIN> ;
chomp $searchstring ;
my %openingChars ;
my %closingChars ;
for my $i (0 .. (length $delimiters) - 1 ) {
  if ( $i % 2 == 0 ) {
      $openingChars{ substr( $delimiters , $i , 1 ) }++ ;
  }
  else {
      $closingChars{ substr( $delimiters, $i , 1 ) }++ ;
  }
}
my $firstOutput ;
my $secondOutput ;
my $len = length $searchstring ;
for my $i (0 .. $len - 1 ) {
  my $letter = substr( $searchstring , $i , 1 ) ;
  if ( exists ( $openingChars{ $letter } ) ) {
      $firstOutput .= $letter ;
  }
  if ( exists ( $closingChars{ $letter } ) ) {
      $secondOutput .= $letter ;
  }
}
say $firstOutput ;
say $secondOutput ;

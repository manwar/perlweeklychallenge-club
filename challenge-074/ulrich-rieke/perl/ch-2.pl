#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my $S = $ARGV[ 0 ] ;
my %letterfrequencies ;
my $FNR ;
my @letters = split( // , $S ) ;
while ( @letters ) {
  my $currentLetter = shift @letters ;
  $letterfrequencies{ $currentLetter }++ ;
  if ( $letterfrequencies{ $currentLetter } == 1 ) {
      $FNR .= $currentLetter ;
  }
  if ( $letterfrequencies{ $currentLetter } > 1 ) {
      my @uniqueLetters = grep { $letterfrequencies{ $_ } == 1 }
      keys %letterfrequencies ;
      my $len = scalar @uniqueLetters ;
      if ( $len == 1 ) {
    $FNR .= $uniqueLetters[ 0 ] ;
      }
      if ( $len > 1 ) {
    my $i = length $FNR - 1 ;
    while ( $letterfrequencies{ substr( $FNR , $i , 1 ) } != 1 ) {
        $i-- ;
    }
    $FNR .= substr( $FNR , $i , 1 ) ;
      }
      if ( $len == 0 ) {
    $FNR .= "#" ;
      }
  }
}
say $FNR ;

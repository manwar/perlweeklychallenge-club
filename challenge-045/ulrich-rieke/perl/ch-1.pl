#!/usr/bin/perl ;
use strict ;
use warnings ;

sub encode {
  my $str = shift ;
  my @strings ;
  my $times = int ( (length $str) / 8 ) ;
  my $pos = 0 ;
  for ( my $i = 0 ; $i < $times ; $i++ ) {
      push @strings, substr( $str, $pos , 8 ) ;
      $pos += 8 ;
  }
  push @strings , substr( $str, $pos ) ;
  my $encoded ;
  for ( my $i = 0 ; $i < 8 ; $i++ ) {
      for my $word ( @strings ) {
    my $len = length $word ;
    if ( $len > $i ) {
        $encoded .= substr( $word , $i , 1 ) ;
    }
      }
  }
  my $stringslen = scalar @strings ;
  my $len = length $encoded ;
  $times =  length $strings[-1]  ;
  my @encodedStrings ;
  $pos = 0 ;
  for ( my $i = 0 ; $i < $times ; $i++ ) {
      push @encodedStrings, substr( $encoded , $pos , $stringslen ) ;
      $pos += $stringslen ;
  }
  my $theRest = 8 - $times ;
  for ( my $i = 0 ; $i < $theRest ; $i++ ) {
      push @encodedStrings , substr( $encoded , $pos , $stringslen - 1 ) ;
      $pos += $stringslen - 1 ;
  }
  return ( join ( ' ' , @encodedStrings ) ) ;
}
my $toBeEncoded = join ('', @ARGV) ;
my $encoded = encode( $toBeEncoded ) ;
print "$encoded\n" ;

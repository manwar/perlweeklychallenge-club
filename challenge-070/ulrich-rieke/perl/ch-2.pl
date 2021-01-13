#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#function to convert a binary string to a decimal number!
#Of course, we have pack and unpack, but this seems less unwieldy...
sub binToDecimal {
  my $binary = shift ;
  my $decimal = 0 ;
  my $expo = 1 ;
  my @reversed = reverse split (// , $binary) ;
  for my $num ( @reversed ) {
      $decimal += ( $expo * $num ) ;
      $expo *= 2 ;
  }
  return $decimal ;
}

my $limit = $ARGV[ 0 ] ;
my @current = ("0" , "1" ) ;
my $n = 1 ;
while ( $n < $limit ) {
  for my $element ( reverse @current ) {
      push( @current , $element ) ;
  }
  my $len = scalar @current ;
  for my $i (0..$len / 2 - 1 ) {
      $current[ $i ] = "0" . $current[ $i ] ;
  }
  for my $i ( $len / 2 .. $len - 1 ) {
      $current[ $i ] = "1" . $current[ $i ] ;
  }
  $n++ ;
}
my @numbers = map { binToDecimal( $_ ) } @current ;
say join (', ' , @numbers ) ;


#!/usr/bin/perl ;
use strict ;
use warnings ;

sub mySwitch {
  my $num = shift ;
  for my $i (0..length( $num ) - 1) {
      if ( substr( $num, $i , 1 ) eq "1" ) {
    substr( $num, $i , 1 ) = "0" ;
      }
      else {
    substr( $num, $i , 1 ) = "1" ;
      }
  }
  return $num ;
}

my $current = 0 ;
my $n = 1 ;
while ( $n < 30 ) {
  $current = $current . "0" . mySwitch( scalar reverse $current ) ;
  $n++ ;
}
print "S30 is $current!\n" ;

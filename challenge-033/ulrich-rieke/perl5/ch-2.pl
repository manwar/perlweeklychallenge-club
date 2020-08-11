#!/usr/bin/perl ;
use strict ;
use warnings ;

printf("%4s" , "x|") ;
foreach my $num (1..11) {
  printf("%4d", $num) ;
}
print "\n" ;
print "-" x 48 ;
print "\n" ;
for (my $i = 1 ; $i < 12 ; $i++ ) {
  printf( "%4s" , "$i|" ) ;
  if ( $i > 1 ) {
      print " " x ( ($i - 1 ) * 4 ) ;
  }
  for (my $mult = $i ; $mult < 12 ; $mult++) {
      printf( "%4d" , $i * $mult ) ;
  }
  print "\n" ;
}

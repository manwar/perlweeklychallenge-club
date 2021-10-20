#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my $sedol = $ARGV[0] ;
my $teststring = uc( $sedol ) ;
my $valid = 0 ;
if ( ( $teststring !~ /\A\w{7}\z/ ) || ( $teststring =~ /[AEIOU]/ )
      || ( $teststring =~ /_/ )) {
  $valid = 0 ;
}
else {
  my @factors = ( 1, 3 , 1 , 7 , 3 , 9 , 1 ) ;
  my $sum = 0 ;
  for my $i ( 0 .. 5 ) {
      my $letter = substr( $teststring , $i , 1 ) ;
      if ( $letter =~ /\p{N}/ ) {
    $sum += $letter * $factors[ $i ] ;
      }
      if ( $letter =~ /\p{Lu}/ ) {
    $sum += ( ord( $letter ) - 55 ) * $factors[ $i ] ;
      }
  }
  if ( (substr( $teststring, 6 , 1 ) + 0 ) == ( (10 - ( $sum % 10 )) % 10 )) {
      $valid = 1 ;
  }
}
say $valid ;

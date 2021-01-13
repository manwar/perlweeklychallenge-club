#!/usr/bin/perl ;
use strict ;
use warnings ;

sub isColourful {
  my $number = shift ;
  my %numHash ;
  if ( $number =~ /(\d)(\d)(\d)/ ) {
      $numHash{ $1 * $2 }++ ;
      $numHash{ $2 * $3 }++ ;
      $numHash{ $1 * $2 * $3 }++ ;
      $numHash{ $1 }++ ;
      $numHash{ $2 }++ ;
      $numHash{ $3 }++ ;
      $numHash{ $1 * $3 }++ ;
      return scalar  keys %numHash == 7 ;
  }
  return 0 ;
}

foreach my $num (100..999) {
  if ( isColourful( $num ) ) {
      print "$num\n" ;
  }
}

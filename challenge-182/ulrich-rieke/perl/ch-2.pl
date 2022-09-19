#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

open ( my $fh , '< inputfiles.txt' ) or die "Can't open inputfiles.txt !\n" ;
my @input ;
while ( my $line = <$fh> ) {
  chomp $line ;
  push @input , $line ;
}
close ( $fh ) ;
my $comparedTo = $input[ 0 ] ;
my $len = scalar( @input ) ;
my $pos = -1 ;
my $count = 0 ;
do {
  $pos++ ;
  $count = 0 ;
  for my $i ( 1 .. $len - 1 ) {
      if ( substr( $input[ $i ] , $pos , 1 ) eq substr( $comparedTo , $pos ,
          1 )) {
    $count++ ;
      }
  }
} while ( $count == ( $len - 1 )) ;
say substr( $comparedTo , 0 , $pos ) ;

#!/usr/bin/perl ;
use strict ;
use warnings ;

my $N = $ARGV[ 0 ] ;
die "Wrong entry" unless ( $N =~ /\b\d+\b/ ) ;
my $count = 1 ;
my $pos = 0 ;
my $output ;
my $num = substr( $N, $pos , 1 ) ;
my $lastValue = $num ;
$pos = 1 ;
while ( $pos < length $N ) {
  $num = substr( $N , $pos , 1 ) ;
  if ( $num eq $lastValue ) {
      $count++ ;
  }
  else {
      $output .= ( $count . $lastValue ) ;
      $lastValue = $num ;
      $count = 1 ;
  }
  $pos++ ;
}
if ( $count == 1 ) {
  $output .= ( $count . $lastValue ) ;
}
print "$output\n" ;

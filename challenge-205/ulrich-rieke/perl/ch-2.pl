#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my $size = scalar( @ARGV ) ;
my $max = 0 ;
for my $i ( 0 .. $size - 2 ) {
  for my $j ( $i + 1 .. $size - 1 ) {
      if ( $ARGV[ $i ] != $ARGV[ $j ] ) {
    my $num = $ARGV[ $i ] ^ $ARGV[ $j ] ;
    if ( $num > $max ) {
        $max = $num ;
    }
      }
  }
}
say $max ;

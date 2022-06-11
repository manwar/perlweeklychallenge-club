#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( any ) ;

my $potentialHex = '^[0-9a-f]{2,8}$' ;
my @hexwords ;
my $line ;
open ( my $fh , "< dictionary.txt" ) or die "Can't open file: $!" ;
while ( $line = <$fh> ) {
  chomp $line ;
  if ( $line =~ /$potentialHex/ ) {
      push @hexwords , "0x$line" ;
  }
  else {
      $line =~ tr/olist/01157/ ;
      if ( $line =~ /$potentialHex/ ) {
    push @hexwords , "0x$line" ;
      }
  }
}
close( $fh ) ;
say join( ',' , @hexwords ) ;

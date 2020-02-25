#!/usr/bin/perl ;
use strict ;
use warnings ;

sub isGapful {
  my $number = shift ;
  $number =~ /(\d)\d+(\d)/ ;
  my $first = $1 ;
  my $last = $2 ;
  return ( ($number % ( $first . $last )) == 0 ) ;
}

my @numbers ;
my $start = 99 ;
while ( scalar @numbers != 20 ) {
  $start++ ;
  if ( isGapful( $start ) ) {
      push( @numbers, $start ) ;
  }
}

map { print "$_ " } @numbers ;
print "\n" ;

#!/usr/bin/perl ;
use strict ;
use warnings ;

sub findNobles {
  my $randoms = shift ;
  my %randHash ;
  for my $elem ( @{$randoms} ) {
      $randHash{$elem}++ ;
  }
  my @sorted = sort { $a <=> $b } keys %randHash ;
  my $len = scalar @sorted ;
  my @nobles ;
  foreach my $i (0..$len - 1  ) {
      if ( $sorted[ $i ] == $len - 1 - $i ) {
    push( @nobles, $sorted[ $i ] ) ;
      }
  }
  return @nobles ;
}

my $howmany = int( rand( 51 ) ) ;
my @randomnumbers ;
for my $i (1..$howmany) {
  push( @randomnumbers , int( rand( 51 ) ) ) ;
}
my @nobles = findNobles( \@randomnumbers ) ;
if ( @nobles ) {
  map { print "$_ " } @nobles ;
  print "\n" ;
}
else {
  print "There are no nobles this time!\n" ;
}

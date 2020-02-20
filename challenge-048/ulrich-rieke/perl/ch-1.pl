#!/usr/bin/perl ;
use strict ;
use warnings ;

sub findNextAlive {
  my $pos = shift ;
  my $array = shift ;
#we have to do one step to the right to get away from the last position
#important to wrap around the end of the array if necessary!
  $pos++ ;
  if ( $pos > 49 ) {
      $pos = $pos % 50 ;
  }
  while ( ${$array}[ $pos ] !~ /\d+/ ) {
      $pos++ ;
      if ( $pos > 49 ) {
    $pos = $pos % 50 ;
      }
  }
  return $pos ;
}

my @people = (1..50) ;
my $sword_at = 0 ;
my $size = 50 ;
while ( $size != 1 ) {
#the first neighbour to the right of the sword will be killed, the
#next neighbour in the same direction will get the sword.
  my $victimpos = findNextAlive( $sword_at , \@people ) ;
  $people[ $victimpos ] = "dead" ;
  $sword_at = findNextAlive( $victimpos , \@people ) ;
  $size = scalar grep { $_ =~ /\d+/ } @people ;
}
my @survivors = grep { $_ =~ /\d+/ } @people ;
print "The last survivor is $survivors[0] !\n" ;

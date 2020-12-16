#!/usr/bin/perl ;
use strict ;
use warnings ;

sub enterArray {
  my @array ;
  print "Enter positive numbers , -1 to end!\n";
  my $num = <STDIN> ;
  chomp $num ;
  while ( $num != -1 ) {
      push @array , $num ;
      $num = <STDIN> ;
      chomp $num ;
  }
  return @array ;
}

my @array = enterArray( ) ;
my $len = scalar @array ;
my $value = 0 ;
my $current = 0 ;
while ( $array[ $current ] ) {
  $current += $array[ $current ] ;
  if ( $current == $len - 1 ) {
      $value = 1 ;
      last ;
  }
  if ( $current < $len - 1 and $array[ $current ] == 0 ) {
      last ;
  }
}
print "$value\n" ;

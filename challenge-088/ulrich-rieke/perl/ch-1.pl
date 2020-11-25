#!/usr/bin/perl ;
use strict ;
use warnings ;
use List::Util qw( product ) ;

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

my @array = enterArray ;
my @M ;
my $product = product @array ;
my $len = scalar @array ;
for my $i ( 0 .. $len - 1 ) {
  push @M , $product / $array[ $i ] ;
}
print "( " ;
map { print "$_ " } @M ;
print ")\n" ;

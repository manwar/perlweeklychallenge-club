#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw( combinations ) ;

sub enterArray {
  my @array ;
  say "Enter positive numbers , -1 to end";
  my $num = <STDIN> ;
  chomp $num ;
  while ( $num != -1 ) {
      push @array , $num ;
      $num = <STDIN> ;
      chomp $num ;
  }
  return @array ;
}

my $A = $ARGV[ 0 ] ;
my @array = enterArray( ) ;
my @sorted = sort { $b <=> $a } @array ;
my $output = 0 ;
my $iter = combinations(\@sorted, 2 ) ;
while ( my $p = $iter->next ) {
  if ( $p->[0] - $p->[1] == $A ) {
      $output = 1 ;
      last ;
  }
}
say $output ;
